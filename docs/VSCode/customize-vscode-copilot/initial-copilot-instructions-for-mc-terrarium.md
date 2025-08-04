
# GitHub Copilot Instructions for MC-Terrarium

## Project Overview

MC-Terrarium is a multi-cloud infrastructure management platform that provides VPN site-to-site connections, object storage, SQL databases, message brokers, and testbed environments across different Cloud Service Providers (AWS, GCP, Azure, Alibaba Cloud, Tencent Cloud, IBM Cloud, NCP).

## Architecture Pattern

### Template-based Infrastructure Deployment

The project follows a template-based deployment pattern:

1. **Template Storage**: OpenTofu/Terraform templates are stored in `/templates/` directory
2. **Runtime Copying**: On API calls, templates are copied to `.terrarium/{trId}/` workspace
3. **Execution Context**: All OpenTofu operations (init, plan, apply, destroy) run within the terrarium-specific directory
4. **Isolation**: Each terrarium ID gets its own isolated workspace for state management

### Workspace Structure

```
API Call → Copy Templates → Initialize Workspace → Execute Operations
├── templates/{service}/                    (source templates)
│   ├── vpn/site-to-site/
│   ├── vpn/aws-to-site/
│   ├── object-storage/
│   ├── sql-db/
│   ├── message-broker/
│   └── testbed/
└── .terrarium/{trId}/                     (runtime workspace)
    ├── {service}/
    │   ├── *.tf files (copied from templates)
    │   ├── modules/ (copied from templates)
    │   ├── terraform.tfvars.json
    │   ├── terraform.tfstate
    │   └── .terraform/
    └── vpn/{provider-pair}/               (for VPN connections)
```

## Code Style and Standards

### Go Code Guidelines

- Use structured logging with `github.com/rs/zerolog/log`
- Follow Echo framework patterns for REST API handlers
- Implement proper error handling with HTTP status codes
- Use godoc comments for all exported functions
- Follow the handler workflow pattern: Init → Plan → Apply for creation, Destroy → EmptyOut for deletion
- Always validate terrarium ID in path parameters
- Use `c.Response().Header().Get(echo.HeaderXRequestID)` for request tracking

### Template Management Guidelines

- Store reusable templates in `/templates/` directory structure organized by service
- Design templates to be parameterized through variables
- Ensure templates are CSP-agnostic where possible
- Include proper resource naming with terrarium ID prefix
- Handle template copying and workspace initialization in handler functions
- Use `tfutil.CopyFiles()` for template copying operations

### OpenTofu/Terraform Guidelines

- Use descriptive variable names with proper type definitions
- Include validation blocks for input parameters
- Add comprehensive descriptions for all variables
- Use `optional()` with sensible defaults for CSP-specific configurations
- Group variables by CSP (aws, gcp, azure, alibaba, tencent, ibm, ncp)
- Design for workspace isolation with terrarium-specific naming
- Structure BGP peering CIDRs with `to_xxx` naming convention for clarity
- Ensure /30 subnet alignment for BGP peering (network addresses must be multiples of 4)
- Validate APIPA ranges within Azure reserved space (169.254.21.0 ~ 169.254.22.255)

### API Design Patterns

- Follow RESTful conventions with consistent endpoint patterns
- Use `model.Response` type for all API responses
- Implement proper HTTP status codes:
  - 201 for resource creation
  - 200 for successful operations
  - 400 for bad requests
  - 500 for internal server errors
  - 503 for service unavailable
- Include request ID headers for tracing
- Use path parameters for resource identification (trId)
- Structure request models with proper validation
- Use pointer types for optional complex structures

## Service-Specific Patterns

### VPN Site-to-Site Connections

#### Module Structure
- **Base Infrastructure**: CSP-specific VPN gateway templates (`/templates/vpn/site-to-site/{csp}/`)
- **Connection Modules**: Reusable connection logic (`/templates/vpn/site-to-site/modules/conn-{csp1}-{csp2}/`)
- **Implementation Layer**: Module invocation (`/templates/vpn/site-to-site/conn-{csp1}-{csp2}/`)

#### Naming Convention
CSP names in connection modules are ordered alphabetically:
- `conn-aws-azure` (not `conn-azure-aws`)
- `conn-azure-gcp` (not `conn-gcp-azure`)
- `conn-alibaba-aws` (not `conn-aws-alibaba`)

#### Handler Pattern
```go
// Site-to-Site VPN Actions follow this pattern
func InitSiteToSiteVpn(c echo.Context) error
func PlanSiteToSiteVpn(c echo.Context) error
func ApplySiteToSiteVpn(c echo.Context) error
func OutputSiteToSiteVpn(c echo.Context) error
func DestroySiteToSiteVpn(c echo.Context) error
func EmptyOutSiteToSiteVpn(c echo.Context) error
```

### Object Storage

- Use `model.CreateInfracodeOfObjectStorageRequest` for infracode creation
- Working directory: `.terrarium/{trId}/{enrichments}`
- Save variables to `terraform.tfvars.json`
- Validate `TerrariumID` field and set from path parameter if empty

### SQL Database

- Use `model.CreateInfracodeOfSqlDbRequest` for infracode creation
- Follow same workspace pattern as object storage
- Include comprehensive validation for database configurations

### Message Broker

- Use `model.CreateInfracodeOfMessageBrokerRequest`
- Support multiple message broker types across CSPs

### Testbed

- Generate SSH access information for each CSP
- Provide output in both refined and raw formats
- Support parallel resource info retrieval

## Multi-Cloud Considerations

### Default Configurations by CSP

- **AWS**: Region `ap-northeast-2` (Seoul), BGP ASN `64512`
- **GCP**: Region `asia-northeast3` (Seoul), BGP ASN `65530`
- **Azure**: BGP ASN `65531`, VPN SKU `VpnGw1AZ`, region `koreacentral`
- **Alibaba**: Region `ap-northeast-2`, BGP ASN `65532`
- **Tencent**: Region `ap-seoul`, BGP ASN `65534`
- **IBM**: Region `au-syd` (Sydney), BGP ASN `65533`
- **NCP**: Support for Naver Cloud Platform credentials

### APIPA Address Management

For VPN BGP peering, follow standardized APIPA address allocation:

- **Azure**: Always uses `.2` addresses (e.g., `169.254.21.2`, `169.254.21.6`)
- **Other CSPs**: Always use `.1` addresses (e.g., `169.254.21.1`, `169.254.21.5`)
- **Azure Reserved Range**: 169.254.21.0 ~ 169.254.22.255 (Azure VPN requirement)
- **CSP-Specific Ranges**:
  - AWS: 169.254.21.x ~ 169.254.22.x
  - GCP: 169.254.23.x ~ 169.254.24.x
  - Alibaba: 169.254.25.x ~ 169.254.26.x
  - Tencent: 169.254.27.x ~ 169.254.28.x
  - IBM: 169.254.29.x ~ 169.254.30.x

## Common Handler Patterns

### Error Handling

```go
if err != nil {
    log.Error().Err(err).Msg(err.Error())
    res := model.Response{
        Success: false,
        Message: err.Error(),
    }
    return c.JSON(http.StatusInternalServerError, res)
}
```

### Success Response Pattern

```go
res := model.Response{
    Success: true,
    Message: "operation successfully completed",
    Detail:  result, // optional
}
return c.JSON(http.StatusOK, res) // or StatusCreated for creation
```

### Workspace Validation

```go
workingDir := projectRoot + "/.terrarium/" + trId + "/" + enrichments
if _, err := os.Stat(workingDir); os.IsNotExist(err) {
    err2 := fmt.Errorf("working directory does not exist")
    log.Warn().Err(err).Msg(err2.Error())
    res := model.Response{
        Success: false,
        Message: err2.Error(),
    }
    return c.JSON(http.StatusInternalServerError, res)
}
```

### TfVars Handling

```go
// Always ensure terrarium ID is set
if req.TfVars.TerrariumID == "" {
    log.Warn().Msgf("terrarium ID is not set, Use path param: %s", trId)
    req.TfVars.TerrariumID = trId
}

// Save to terraform.tfvars.json
tfVarsPath := workingDir + "/terraform.tfvars.json"
err = tfutil.SaveTfVars(req.TfVars, tfVarsPath)
```

## OpenTofu Command Execution

### Standard Commands

- Use `terrarium.Init()`, `terrarium.Plan()`, `terrarium.Apply()`, `terrarium.Destroy()` for basic operations
- Use `terrarium.Show()` with `-json` flag for output operations
- Use `tofu.ExecuteCommand()` with `-chdir` for directory-specific operations

### Output Processing

#### Refined Output (Default)
- Extract specific resource information using parallel goroutines
- Merge results into `allResourceInfo` map
- Use `json.MarshalIndent()` for pretty printing in logs

#### Raw Output
- Parse JSON output from `terrarium.Show()`
- Extract resources from both root module and child modules
- Return as list of raw resource objects

## Swagger/OpenAPI Annotations

### Standard Annotations for Handlers

```go
// HandlerName godoc
// @Summary Brief description
// @Description Detailed description
// @Tags [Service Name] Operations
// @Accept json
// @Produce json
// @Param trId path string true "Terrarium ID" default(tr01)
// @Param ParamsForInfracode body model.RequestType true "Parameters description"
// @Param x-request-id header string false "Custom request ID"
// @Success 201 {object} model.Response "Created"
// @Failure 400 {object} model.Response "Bad Request"
// @Failure 500 {object} model.Response "Internal Server Error"
// @Failure 503 {object} model.Response "Service Unavailable"
// @Router /tr/{trId}/service/endpoint [post]
```

## Security and Validation

### Input Validation

- Always validate terrarium ID from path parameters
- Implement proper request binding with error handling
- Validate CSP-specific configurations in model validation methods
- Sanitize inputs to prevent directory traversal attacks

### Credential Management

- Store credentials in `/secrets/` directory
- Use environment-specific credential files (e.g., `credential-gcp.json`)
- Load credentials through shell scripts for different CSPs
- Never hardcode sensitive information

## File Organization

```
pkg/api/rest/
├── handler/           # REST API handlers
│   ├── vpn-site-to-site.go
│   ├── vpn-site-to-site-actions.go
│   ├── vpn-gcp-aws.go
│   ├── vpn-gcp-azure.go
│   ├── object-storage.go
│   ├── sql-db.go
│   ├── message-broker.go
│   └── testbed.go
├── model/            # Request/Response models
└── routes/           # Route definitions

templates/            # OpenTofu/Terraform templates
├── vpn/
│   ├── site-to-site/
│   └── aws-to-site/
├── object-storage/
├── sql-db/
├── message-broker/
└── testbed/

.terrarium/{trId}/    # Runtime workspaces
```

## Testing Considerations

- Include unit tests for validation methods in models
- Test error scenarios and edge cases
- Validate multi-cloud compatibility
- Test workspace isolation and cleanup
- Verify template copying mechanisms
- Test APIPA address validation and conflict detection
- Validate parallel processing in output handlers

## Documentation Requirements

- Include comprehensive Swagger annotations for all endpoints
- Document CSP-specific requirements and limitations
- Provide examples for multi-cloud configurations
- Document workspace management and template structure
- Include troubleshooting guides for common issues

## Avoid These Patterns

- Don't hardcode secrets or sensitive data
- Don't use generic error messages without context
- Don't skip input validation
- Don't mix different CSP configurations in single resources
- Don't use deprecated Terraform syntax (use OpenTofu best practices)
- Don't access templates directly - always work through workspace copies
- Don't ignore workspace isolation - always operate within terrarium-specific directories
- Don't create APIPA address conflicts between CSPs
- Don't use inconsistent address assignment (.1 vs .2) across connections
- Don't forget to validate APIPA ranges and /30 subnet alignment
- Don't ignore error handling in parallel processing
- Don't skip logging for debugging and monitoring