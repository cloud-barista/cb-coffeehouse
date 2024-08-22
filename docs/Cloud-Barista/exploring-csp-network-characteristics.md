# Exploring CSP etwork characteristics

> [!NOTE]
> I'm trying to share this draft in advance and continue editing it. Help wanted 😃

Hi folks 👋

Let's imagine configuring a network for multiple CSPs at once. It would be very convenient. But, on the other hand, you may encounter uncomfortable situations. **For example, if a configuration fails because it does not meet the network requirements of one CSP, it could lead to overall configuration failure.** In this case, we will have to roll back all configured networks and then reconfigure them all again.

So, first, I would like to explore and organize the network characteristics of CSPs. Second, **I could provide a validation function before configuring networks to multiple CSPs** (It's possible after the characteristics information is successfully organized). Finally, I'm considering modifying property values, which represent network requirements, to reflect changes by CSPs or users.

**I hope I complete this journey successfully. I'm always waiting for your valuable feedbacks and contributions.**

### Summary based on network characteristics of CSPs

#### Validation candidates
- Related to VPC configuration
	- Private IPv4 address ranges (base line)
		- e.g., 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
	- VPC quota
		- e.g., NCP allows 3 VPCs
	- Allowed prefix length range
		- e.g., AWS allows min /28 ~ max /16
		- e.g., MS Azure allows min /29 ~ max /8
		- e.g., GCP allows min /29 ~ max /8
	- Allowed CIDR blocks 
		- e.g., CloudIt allows 10.0.0.0/16
	- Disallowed CIDR blocks
		- e.g., AWS **recommends** not to use 172.17.0.0/16 CIDR range
	- Reserved number of IPs / available number of IPs 
		- e.g.,  NCP reserves the first 5 IPs in a subnet so 5 IPs are excluded from the available quantity
- Related to Subnet configuration
	- Subnet quota(?)
		- e.g., NCP allows 200 subnets
	- Allowed CIDR blocks
		- e.g., CloudIt allows 10.0.4.0/22,10.0.8.0/22, .... 10.0.248.0/22
- Related to Kubernetes configuration
	- Allowed prefix length range
		- e.g., NCP allows only the subnets /17-/26 are available within the VPC bandwidth 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
	- Disallowed CIDR blocks
		- e.g., NCP disallows the subnets in the range of 172.17.0.0/16 to prevent conflict with the Docker Bridge bandwidth 

🤔 If validation conditions are different in each CSP, the validator only has about 11 condition groups.
🤔 If validation conditions are different in each CSP region, the validator will have as many validation condition groups as there are regions and lead to memory intensive.

### A useful reference
- [What Makes Google Cloud Platform (GCP) Networking Service Different From Other Cloud Providers?](https://eclipsys.ca/what-makes-google-cloud-platform-gcp-networking-service-different-from-other-cloud-providers/) on August 17, 2021 by Kosseila Hd
	- AWS Virtual Private Cloud (VPC) CIDR block size range: min /28 ~ max /16
	- MS Azure Virtual Network (VNet) CIDR block size range: min /29 ~ max /8
	- OCI Virtual Cloud Network (VCN) CIDR block size range: min /30 ~ max /16
	- GCP VCP network (actually subnet) CIDR block size range: min /29 ~ max /8
		- Note - GCP VPC contains no CIDR Block. The subnet is the only resource where a CIDR block range is defined.

- Note - (Alvin's opinion) I think it must be confirmed if the VPC CIDR block ranges apply to all regions in each CSP. (Assume VPC CIDR block ranges may vary by region)

### Network characteristics for infrastructure provisioning

#### AWS's IPv4 VPC CIDR block

**Issues 🙌:** 
- The **allowed block size** is between a `/16` netmask (65,563 IP addresses) and `/28` netmask (16 IP addresses)
- Some AWS services use the 172.17.0.0/16 CIDR range. To avoid future conflicts, **don’t use this range** when creating your VPC.

References:
- IPv4 VPC CIDR blocks: https://docs.aws.amazon.com/vpc/latest/userguide/vpc-cidr-blocks.html
> When you create a VPC, you must specify an IPv4 CIDR block for the VPC. The allowed block size is between a /16 netmask (65,536 IP addresses) and /28 netmask (16 IP addresses). After you've created your VPC, you can associate additional IPv4 CIDR blocks with the VPC. For more information, see Add an IPv4 CIDR block to your VPC.

> When you create a VPC, we recommend that you specify a CIDR block from the private IPv4 address ranges as specified in RFC 1918.

> |RFC 1918 range |Example CIDR block|
> |---|---|
> |10.0.0.0 - 10.255.255.255 (10/8 prefix)|10.0.0.0/16|
> |172.16.0.0 - 172.31.255.255 (172.16/12 prefix)|172.31.0.0/16|
> |192.168.0.0 - 192.168.255.255 (192.168/16 prefix)|192.168.0.0/20|

> Important ❗
> Some AWS services use the 172.17.0.0/16 CIDR range. To avoid future conflicts, don’t use this range when creating your VPC. For example, services like AWS Cloud9 or Amazon SageMaker can experience IP address conflicts if the 172.17.0.0/16 IP address range is already in use anywhere in your network. For more information, see Can't connect to EC2 environment because VPC's IP addresses are used by Docker in the AWS Cloud9 User Guide.

#### GCP's 

**Issues 🙌:** 
- GCP VPC does not have CIDR Block

#### NCP's network-related prerequisites

**Issues 🙌:** 
- VPC quota: 3 (default)
- VPC's number of IPs (IPv4): /16-28 (65,536-16)
- Subnet: 
	- **The first 5 IPs are excluded** from the available quantity since they're reserved for network IP, broadcast IP, and internal management. 
	- **The number of available IPs** would be 249 for /24, 121 for /25, and 57 for /26.

References: 
- VPC  quota issue: https://github.com/cloud-barista/cb-spider/issues/1035
	- Default: 3, resolved by requesting quota increase from the customer service center
- NCP's VPC specifications: https://guide.ncloud-docs.com/docs/vpc-manage-vpc#VPC%EC%83%9D%EC%84%B1
> ## Basic specifications
> VPC (Virtual Private Cloud) provides VPC with the following specifications.
> 
> |Items|Standards|Provided specifications|
> |---|---|---|
> |VPC count|Region|3|
> |Number of subnets|VPC|200|
> |Number of IPs (IPv4)|VPC|/ 16- 28 (65,536-16)|
> |Number of NAT Gateway|Zone per VPC|5|
> |Number of Network ACL|VPC|200|
> |Number of Network ACL rules|Network ACL|40|
> |ACG count|VPC|500|
> |Number of ACG rules|ACG|50|
> |Number of ACG Application|Network Interface|3|
> |Number of route tables|VPC|200|
> |Number of route table rules|Route Table|50|
> |Number of VPC Peering|VPC|20| 

- NCP's VPC management: https://guide.ncloud-docs.com/docs/en/vpc-manage-vpc
> When the **Create VPC** pop-up window appears, enter a name and IP address range for the VPC to create.
> - Enter the VPC's name between 3 and 30 characters.
> - Select the IP address range among 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16

- NCP's Subnet Management: https://guide.ncloud-docs.com/docs/en/vpc-subnetmanage-vpc
> - **IP address range**: Specify and enter within the selected VPC address range (example: 10.0.0.0/24, 172.16.1.0/24)
> 	- The first 5 IPs are excluded from the available quantity since they're reserved for network IP, broadcast IP, and internal management. The number of available IPs would be 249 for /24, 121 for /25, and 57 for /26.

#### CLOUDIT's prerequisites

**Issue 🙌:**
- Within CloudIt, assigns specified CIDR block, 10.0.0.0/16
- Only the specified subnets are available (see the following references)

References: 

```go
// set isolated private address space for each cloud region (10.i.0.0/16)
reqTmp.CidrBlock = "10." + strconv.Itoa(i) + ".0.0/16"
if strings.EqualFold(provider, "cloudit") {
	// CLOUDIT: the list of subnets that can be created is
	// 10.0.4.0/22,10.0.8.0/22,10.0.12.0/22,10.0.28.0/22,10.0.32.0/22,
	// 10.0.36.0/22,10.0.40.0/22,10.0.44.0/22,10.0.48.0/22,10.0.52.0/22,
	// 10.0.56.0/22,10.0.60.0/22,10.0.64.0/22,10.0.68.0/22,10.0.72.0/22,
	// 10.0.76.0/22,10.0.80.0/22,10.0.84.0/22,10.0.88.0/22,10.0.92.0/22,
	// 10.0.96.0/22,10.0.100.0/22,10.0.104.0/22,10.0.108.0/22,10.0.112.0/22,
	// 10.0.116.0/22,10.0.120.0/22,10.0.124.0/22,10.0.132.0/22,10.0.136.0/22,
	// 10.0.140.0/22,10.0.144.0/22,10.0.148.0/22,10.0.152.0/22,10.0.156.0/22,
	// 10.0.160.0/22,10.0.164.0/22,10.0.168.0/22,10.0.172.0/22,10.0.176.0/22,
	// 10.0.180.0/22,10.0.184.0/22,10.0.188.0/22,10.0.192.0/22,10.0.196.0/22,
	// 10.0.200.0/22,10.0.204.0/22,10.0.208.0/22,10.0.212.0/22,10.0.216.0/22,
	// 10.0.220.0/22,10.0.224.0/22,10.0.228.0/22,10.0.232.0/22,10.0.236.0/22,
	// 10.0.240.0/22,10.0.244.0/22,10.0.248.0/22

	// temporally assign 10.0.40.0/22 until new policy.
	reqTmp.CidrBlock = "10.0.40.0/22"
}
```

References:
- `# [Cloudit Driver] Creating a VPC, Need to enhance the naming convention of the subnet.`: https://github.com/cloud-barista/cb-spider/issues/319#issuecomment-842921132
- `CLOUDIT: the list of subnets that can be created is`: https://github.com/cloud-barista/cb-tumblebug/blob/6ffe9d575366f93dbae91b7671faa3e4b474a439/src/core/mcir/common.go#L1693

### Network characteristics for Kubernetes (cluster) provisioning

#### MS Azure's IP address range

**Issue 🙌:**
- Inufficient subnet size

References: 
- Need a bigger vNet's IP address range: https://github.com/cloud-barista/cb-tumblebug/issues/1409
> Message="Pre-allocated IPs 218 exceeds IPs available 123 in Subnet Cidr 192.168.4.128/25, Subnet Name az-ea-syk-cm0mdaq3egva5e0k1vp0. http://aka.ms/aks/insufficientsubnetsize"

> Message="Pre-allocated IPs 436 exceeds IPs available 251 in Subnet Cidr 192.168.2.0/24, Subnet Name az-krc-syk-clsj71a3egva36qqt700. http://aka.ms/aks/insufficientsubnetsize"

- CIDR block issue: https://github.com/cloud-barista/cb-tumblebug/issues/1409
- Resolved by https://github.com/cloud-barista/cb-tumblebug/pull/1421
- Operation 3: Creating an AKS cluster or adding an AKS node pool: https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/insufficientsubnetsize-error-advanced-networking#operation-3-creating-an-aks-cluster-or-adding-an-aks-node-pool


#### Ncloud Kubernetes' prerequisites

**Issue 🙌:** 
- A VPC is needed for creating Kubernetes clusters.
- Subnets:
	- **Only the subnets /17-/26 are available** within the VPC bandwidth (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16)
	- The subnets in the range of 172.17.0.0/16 **cannot** be used to prevent conflict with the Docker Bridge bandwidth 
	- Subnets dedicated to Load Balancer **cannot** be used
- Load Balancer Subnet
	- **Only the subnets /17-/26 are availabl**e within the VPC bandwidth (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16)    
	- Public LB Subnet and Private LB Subnet are **required** to create Load Balancer by network type
	- The subnets in the range of 172.17.0.0/16 **cannot** be used to prevent conflict with the Docker Bridge bandwidt

References:
- Preparations for cloud environments: https://guide.ncloud-docs.com/docs/k8s-k8sprep
> The preparations needed to be made in a cloud environment to use Ncloud Kubernetes Service are as follows.
> 
> |Item |Description|Guide|
> |---|---|---|
> |VPC|Virtual cloud space for creating Kubernetes clusters|[Create VPC](https://guide.ncloud-docs.com/docs/en/vpc-start-vpc)|
> |Subnet|Subnet within a virtual cloud space  <br>- Only the subnets /17-/26 are available within the VPC bandwidth (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16)  <br>    <br>- The subnets in the range of 172.17.0.0/16 cannot be used to prevent conflict with the Docker Bridge bandwidth  <br>    <br>- Subnets dedicated to Load Balancer cannot be used|[Create Subnet](https://guide.ncloud-docs.com/docs/en/vpc-subnetmanage-vpc#subnet-%EC%83%9D%EC%84%B1)|
> |Load Balancer Subnet|The subnet for Load Balancer to be linked to a cluster  <br>- Only the subnets /17-/26 are available within the VPC bandwidth (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16)  <br>    <br>- Public LB Subnet and Private LB Subnet are required to create Load Balancer by network type  <br>    <br>- The subnets in the range of 172.17.0.0/16 cannot be used to prevent conflict with the Docker Bridge bandwidth|[Create LB Subnet](https://guide.ncloud-docs.com/docs/en/loadbalancer-start-vpc)|
> |NAT Gateway|Gateway to enable outbound Internet traffic|[Create NAT Gateway](https://guide.ncloud-docs.com/docs/en/networking-vpc-vpcdetailenatgw)|
> |Cloud Log Analytics|(Optional) The service for storing audit logs of a cluster|[CLA User Guide](https://guide.ncloud-docs.com/docs/en/cla-overview)|


### Appendix

#### **Terms** (kor)

- **CIDR (Classless Inter-Domain Routing)**: IP 주소 할당 및 라우팅을 위한 방법으로, 유연한 서브네팅과 IP 주소 공간의 효율적 사용을 가능하게 함.
- **CIDR Block**: 특정 IP 주소 범위를 나타내는 표현 방식. 예: `192.168.0.0/24`에서 '192.168.0.0'은 네트워크 시작 주소를 나타내고, '/24'는 서브넷 마스크 길이(즉, 접두사 길이)를 의미하며, 이를 통해 IP 주소 범위가 결정됨.
- **Prefix Length**: CIDR block에서 네트워크 부분 또는 서브넷 부분을 정의하는 비트 수를 의미함. 네트워크 또는 서브넷 마스크에서 '1'의 개수로 표현됨. 예: `/24`, `/28` 등.
- **CIDR Address**: 특정 네트워크 또는 호스트를 식별하는 특정 IP 주소를 의미함. 예: `192.168.1.0/24` CIDR block (이 또한 CIDR address) 내의 `192.168.1.5/24`는 CIDR address로, 네트워크 내 특정 장치나 호스트를 식별함.
- **IP Address (Internet Protocol Address)**: 인터넷 프로토콜을 사용하는 컴퓨터 네트워크에 연결된 각 장치에 할당된 고유한 숫자 라벨. 네트워크 인터페이스 식별 및 위치 주소 지정의 두 가지 주요 기능을 수행함. 예, `192.168.0.0`, `192.168.0.7`,  등.
- **Address Range / IP Range**: CIDR block 내에 포함된 IP 주소의 범위를 의미함. 예: '192.168.0.0/24'의 주소 범위는 `192.168.0.0`부터 `192.168.0.255`까지 총 256개의 IP 주소를 포함함.
- **Address Space**: CIDR block 내 주소의 총 개수를 의미함. 예: 192.168.0.0/24의 경우, 주소 공간은 `256 (=2^8)`개의 주소를 포함함.
- **Network Address**: CIDR block의 첫 번째 주소로, 네트워크 자체를 식별하는 데 사용됨. 예: '192.168.0.0/24'에서 `192.168.0.0`은 네트워크 주소임.
- **Broadcast Address**: CIDR block의 마지막 주소로, 네트워크 내 모든 호스트에 메시지를 브로드캐스팅하는 데 사용됨. '192.168.0.0/24'에서 `192.168.0.255`는 브로드캐스트 주소임.
- **Address Aggregation**: CIDR 구조의 주요 이점 중 하나로, 여러 IP 주소나 네트워크를 단일 라우팅 항목으로 결합하여 라우팅 테이블의 크기를 줄이고 효율적인 라우팅을 가능하게 함.
#### Terms (eng)
- **CIDR**: Classless Inter-Domain Routing (CIDR) is a method for IP address allocation and routing. It allows flexible subnetting and efficient use of IP address space.
- **CIDR Block**: A representation of a specific range of IP addresses. For example, `192.168.0.0/24` indicates a block. '192.168.0.0' represents the network's starting address, and '/24' signifies the length of the subnet mask (or prefix), determining the range of IP addresses.
- **Prefix Length**: In a CIDR block, it defines the number of bits for the netid or subnetid. It's represented by the count of '1's in the network or subnet mask. Examples include `/24`, `/28`, etc.
- **CIDR Address**: Represents a specific network or host using a particular IP address. For instance, `192.168.1.5/24` within the '192.168.1.0/24' CIDR block (also, CIDR address) is a CIDR address, identifying a specific device or host within a network.
- **IP Address / IP**: A unique numerical label assigned to each device connected to a computer network that uses the Internet Protocol for communication. It serves two main functions: network interface identification and location addressing. Eamples includes `192.168.0.0`, `192.168.0.7`, etc.
- **Address Range / IP Range**: The span of IP addresses contained within a CIDR block. For instance, the CIDR range of '192.168.0.0/24' encompasses IP addresses from `192.168.0.0` to `192.168.0.255`, totaling 256 addresses.
- **Address Space**: Refers to the total number of addresses in a CIDR block. For example, the address space for 192.168.0.0/24 is `256 (=2^8)`  addresses.
- **Network Address**: The first address in a CIDR block, used to identify the network itself. For example, in '192.168.0.0/24', `192.168.0.0` is the network address.
- **Broadcast Address**: The last address in a CIDR block, used for broadcasting messages to all hosts within the network. In '192.168.0.0/24', `192.168.0.255` is the broadcast address.
- **Address Aggregation**: A benefit of CIDR structure allowing efficient routing by combining multiple IP addresses or networks into a single routing entry, reducing the size of routing tables.

Backup
* **CIDR**: Classless Inter-Domain Routing (CIDR)은 IP 주소 할당 및 라우팅을 위한 방법
* **CIDR block**:  특정 IP 주소 범위를 표현하는 방식으로, 192.168.0.0/24'와 같은 형태로 나타난다. '192.168.0.0'은 네트워크의 시작 주소를 나타내며, '/24'는 서브넷 마스크의 길이(즉, prefix)를 의미하고, 이를 통해 IP 주소 범위가 결정된다.
* **Prefix length**:  CIDR block에서 netid 또는 subnetid를 정의하는 bit의 수를 의미하며, 즉 network mask 또는 subnet mask에서 1의 개수를 나타낸다. 예를 들어,'/24',  '/28' 등으로 나타난다.
* **CIDR address**: 특정 네트워크 또는 호스트를 나타내는 데 사용되는 특정 IP 주소를 의미합니다. 예를 들어, '192.168.1.0/24' CIDR block 내의 '192.168.1.5/24'는 CIDR address입니다. 이 주소는 개별 호스트 또는 네트워크 내의 특정 장치를 식별합니다.
* IP address: 
* **Address range / IP range**: CIDR block이 포함하는 IP 주소 범위를 말합니다. 예를 들어, '192.168.0.0/24'의 CIDR range는 '192.168.0.0'부터 '192.168.0.255'까지의 256개의 IP 주소를 포함합니다.
* **Address space**: CIDR block의 주소의 개수를 의미한다. 예를 들어, 192.168.0.0/24의 경우 2^8인 256을 나타낸다.
* TBD
	* CIDR 구조의 한 가지 장점은 "주소 결합"이다.
	* Network address
	* (Direct) Broadcast address
