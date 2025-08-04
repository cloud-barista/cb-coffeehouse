
# GitHub Copilot Instructions for MC-Terrarium

## Project Overview

MC-Terrarium is a multi-cloud infrastructure management platform that provides VPN site-to-site connections across different Cloud Service Providers (AWS, GCP, Azure, Alibaba Cloud, Tencent Cloud, IBM Cloud).

## Architecture Pattern

### Template-based Infrastructure Deployment

The project follows a template-based deployment pattern:

1. **Template Storage**: OpenTofu/Terraform templates are stored in `/templates/` directory
2. **Runtime Copying**: On API calls, templates are copied to `.terrarium/{trId}/` workspace
3. **Execution Context**: All OpenTofu operations (init, plan, apply, destroy) run within the terrarium-specific directory
4. **Isolation**: Each terrarium ID gets its own isolated workspace for state management

### Workflow Pattern

```
API Call → Copy Templates → Initialize Workspace → Execute Operations
├── templates/vpn/site-to-site/  (source templates)
└── .terrarium/{trId}/           (runtime workspace)
    ├── *.tf files (copied from templates)
    ├── modules/ (copied from templates)
    ├── terraform.tfstate
    └── .terraform/
```

## Code Style and Standards

### Go Code Guidelines

- Use structured logging with `github.com/rs/zerolog/log`
- Follow Echo framework patterns for REST API handlers
- Implement proper error handling with HTTP status codes
- Use godoc comments for all exported functions
- Follow the handler workflow pattern: Init → Plan → Apply for creation, Destroy → EmptyOut for deletion

### Template Management Guidelines

- Store reusable templates in `/templates/` directory structure
- Design templates to be parameterized through variables
- Ensure templates are CSP-agnostic where possible
- Include proper resource naming with terrarium ID prefix
- Handle template copying and workspace initialization in handler functions

### OpenTofu/Terraform Guidelines

- Use descriptive variable names with proper type definitions
- Include validation blocks for input parameters
- Add comprehensive descriptions for all variables
- Use optional() with sensible defaults for CSP-specific configurations
- Group variables by CSP (aws, gcp, azure, alibaba, tencent, ibm)
- Design for workspace isolation with terrarium-specific naming
- Structure BGP peering CIDRs with `to_xxx` naming convention for clarity
- Ensure /30 subnet alignment for BGP peering (network addresses must be multiples of 4)
- Validate APIPA ranges within Azure reserved space (169.254.21.0 ~ 169.254.22.255)

### API Design Patterns

- Follow RESTful conventions
- Use consistent response models with `model.Response` type
- Implement proper HTTP status codes (201 for creation, 200 for success, 500 for errors)
- Include request ID headers for tracing
- Use path parameters for resource identification (trId)
- Use pointer types for optional complex structures (e.g., `*AzureBgpPeeringCidrs`)
- Implement comprehensive validation with specific error messages
- Structure BGP peering configurations with CSP-specific groupings

## Multi-Cloud Considerations

When suggesting code for different cloud providers:

- **AWS**: Use `ap-northeast-2` (Seoul) as default region, BGP ASN `64512`
- **GCP**: Use `asia-northeast3` (Seoul) as default region, BGP ASN `65530`
- **Azure**: Use BGP ASN `65531`, VPN SKU `VpnGw1AZ`, include APIPA CIDRs
- **Alibaba**: Use `ap-northeast-2` as default region, BGP ASN `65532`
- **Tencent**: Use `ap-seoul` as default region, BGP ASN `65534`
- **IBM**: Use `au-syd` (Sydney) as default region, BGP ASN `65533`

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

### VPN Gateway Redundancy Patterns

- **AWS-GCP**: Use `FOUR_IPS_REDUNDANCY` (AWS: 2 Connections × 2 Tunnels = 4 IPs)
- **Azure-GCP**: Use `TWO_IPS_REDUNDANCY` (Azure: Active-Active = 2 IPs)
- **AWS-Azure**: Use 4 tunnels (AWS auto-generates 2 tunnels per connection)

## Workspace Management Patterns

### Template Copying

```go
// Copy templates from source to terrarium workspace
sourceDir := "templates/vpn/site-to-site/"
targetDir := fmt.Sprintf(".terrarium/%s/", trId)
// Implement recursive copy with proper error handling
```

### Resource Naming Convention

```hcl
# Use terrarium ID as prefix for resource naming
resource "aws_vpn_gateway" "main" {
  tags = {
    Name = "${var.vpn_config.terrarium_id}-vpn-gateway"
    Terrarium = var.vpn_config.terrarium_id
  }
}
```

### State Management

- Each terrarium maintains its own state file in `.terrarium/{trId}/terraform.tfstate`
- Implement proper state locking mechanisms
- Handle concurrent access to terrarium workspaces
- Provide state cleanup in EmptyOut operations

## Security Best Practices

- Always validate input parameters
- Implement proper authentication and authorization
- Use structured error responses that don't leak sensitive information
- Add rate limiting for resource-intensive operations
- Log security events and API access
- Sanitize terrarium ID to prevent directory traversal attacks
- Ensure workspace isolation between different terrarium instances

## File Organization

- REST handlers in `/pkg/api/rest/handler/`
- OpenTofu templates in `/templates/`
- Runtime workspaces in `.terrarium/{trId}/`
- Models in `/pkg/api/rest/model/`
- Follow the existing package structure

## Common Patterns to Follow

### Error Handling

```go
if err != nil {
    log.Error().Err(err).Msg(err.Error())
    return c.JSON(http.StatusInternalServerError, res)
}
```

### Handler Function Structure

```go
func HandlerName(c echo.Context) error {
    // Operation workflow comments
    res, err := operationFunction(c)
    if err != nil {
        // error handling
    }
    return c.JSON(statusCode, res)
}
```

### Workspace Operations

```go
// Pattern for workspace-aware operations
func operationFunction(c echo.Context) (*model.Response, error) {
    trId := c.Param("trId")
    workspaceDir := fmt.Sprintf(".terrarium/%s", trId)

    // Ensure workspace exists and is properly initialized
    // Execute OpenTofu commands in workspace context
    // Handle results and state management
}
```

### Variable Definitions

```hcl
variable "name" {
  description = "Clear description of the variable purpose"
  type        = object({
    field = string
    optional_field = optional(string, "default_value")
  })
}
```

### APIPA CIDR Configuration

```hcl
# Structure BGP peering CIDRs with clear CSP targeting
bgp_peering_cidrs = optional(object({
  to_aws = optional(list(string), [
    "169.254.21.0/30", "169.254.21.4/30",
    "169.254.22.0/30", "169.254.22.4/30"
  ])
  to_gcp = optional(list(string), [
    "169.254.23.0/30", "169.254.23.4/30",
    "169.254.24.0/30", "169.254.24.4/30"
  ])
  # Additional CSP configurations...
}))
```

### BGP Address Assignment

```hcl
# Azure VPN Gateway: Always use .2 addresses
apipa_addresses = [
  for i, cidr in var.azure_apipa_cidrs : cidrhost(cidr, 2) if i % 2 == 0
]

# Other CSP interfaces: Always use .1 addresses
ip_range = "${cidrhost(var.azure_apipa_cidrs[count.index * 2], 1)}/30"
```

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

## VPN Site-to-Site Connection Patterns

### Module Structure

VPN connections follow a modular pattern:

- **Base Infrastructure**: CSP-specific VPN gateway templates (`/templates/vpn/site-to-site/{csp}/`)
- **Connection Modules**: Reusable connection logic (`/templates/vpn/site-to-site/modules/conn-{csp1}-{csp2}/`)
- **Implementation Layer**: Module invocation (`/templates/vpn/site-to-site/conn-{csp1}-{csp2}/`)

**Naming Convention**: CSP names in connection modules are ordered alphabetically:

- `conn-aws-azure` (not `conn-azure-aws`)
- `conn-azure-gcp` (not `conn-gcp-azure`)
- `conn-alibaba-aws` (not `conn-aws-alibaba`)
- `conn-gcp-ibm` (not `conn-ibm-gcp`)

This ensures consistent naming and prevents duplicate modules for the same CSP pair.

### CSP-Specific VPN Characteristics

#### AWS VPN Gateway

- **Tunnel Generation**: Auto-creates 2 tunnels per VPN connection
- **IP Addresses**: Each connection provides tunnel1_address, tunnel2_address
- **BGP**: Uses tunnel1_vgw_inside_address, tunnel2_vgw_inside_address
- **Redundancy**: Create multiple connections for higher availability

#### Azure VPN Gateway

- **Active-Active Mode**: Uses 2 public IP addresses
- **APIPA Requirement**: Must use 169.254.21.0 ~ 169.254.22.255 range
- **BGP Settings**: Configure peering_addresses with ip_configuration_name
- **Address Assignment**: Always use .2 addresses for Azure side

#### GCP HA VPN Gateway

- **Interface Count**: Fixed 2 VPN interfaces per gateway
- **External Gateway**: Configure based on peer CSP redundancy type
- **Router Configuration**: Separate router interfaces and peers for each tunnel
- **Address Assignment**: Always use .1 addresses for GCP side

### Connection-Specific Patterns

#### AWS-Azure Connection

- **Redundancy**: FOUR tunnels (2 AWS connections × 2 tunnels each)
- **APIPA**: AWS gets .1, Azure gets .2
- **Custom CIDRs**: Use tunnel1_inside_cidr, tunnel2_inside_cidr for AWS

#### Azure-GCP Connection

- **Redundancy**: TWO tunnels (Azure Active-Active matches GCP HA)
- **External Gateway**: TWO_IPS_REDUNDANCY on GCP side
- **APIPA**: GCP gets .1, Azure gets .2
- **BGP Peers**: Cross-reference addresses (.1 ↔ .2)

### APIPA Address Validation

Implement comprehensive validation for BGP peering CIDRs:

- **Format Validation**: Ensure valid CIDR notation and /30 subnets
- **Range Validation**: Verify APIPA ranges (169.254.x.x)
- **Azure Range**: Validate within 169.254.21.0 ~ 169.254.22.255
- **Alignment Check**: Ensure network addresses are multiples of 4
- **Duplicate Detection**: Prevent CIDR conflicts across CSP configurations

## Testing Considerations

- Suggest unit tests for handler functions
- Include integration tests for VPN connection workflows
- Test error scenarios and edge cases
- Validate multi-cloud compatibility
- Test workspace isolation and cleanup
- Verify template copying mechanisms
- Test APIPA address validation and conflict detection
- Validate BGP peering configurations across different CSP combinations

## Documentation

- Include Swagger/OpenAPI annotations for all REST endpoints
- Add inline comments for complex business logic
- Document CSP-specific requirements and limitations
- Provide examples for multi-cloud configurations
- Document workspace management and template structure
