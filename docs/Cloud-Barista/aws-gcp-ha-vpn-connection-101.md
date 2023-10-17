
### Prerequisites
#### Create a VPC network and 2 subnets on GCP

- Name: kimy-net00
- VPC network ULA internal IPv6 range: Disabled
- Subnets:
	- Subnet creation mode: Custom
	- New subnet:
		- Name: kimy-net-00-subnet-00
		- Region: asia-northeast3
		- IP stack type: IPv4 (single-stack)
		- IPv4 range: 192.168.0.0/24
		- Private Google Access: On
		- Flow logs: Off
	- New subnet:
		- Name: kimy-net00-subnet01
		- Region: asia-northeast3
		- IP stack type: IPv4 (single-stack)
		- IPv4 range: 192.168.1.0/24
		- Private Google Access: On
		- Flow logs: Off
- Firewall rules
	- IPV4 FIREWALL RULES: allow icmp
	- Dynamic routing mode: Global

#### Create a VPC and 2 subnets on AWS

Create VPC
- Resources to create: VPC only
- Name tag: kimy-net-01
- IPv4 CIDR block
	- Select IPv4 CIDR mnual input
	- IPv4 CIDR: : 192.168.64.0/22
- IPv6 CIDR block
	- No IPv6 CIDR block
- Tenancy: Default

Create subnets
- Select VPC ID: searched by kimy-net-01
- Subnet 1 of 2:
	- Subnet name: kimy-net-01-subnet-00
	- IPv4 VPC CIDR block: 192.168.64.0/22
	- IPv4 subnet CIDR block: 192.168.64.0/24
- Subnet 2 of 2:
	- Subnet name: kimy-net-01-subnet-01
	- IPv4 VPC CIDR block: 192.168.64.0/22
	- IPv4 subnet CIDR block: 192.168.65.0/24

#### Create a security group in AWS
- Security group name: kimy-sg-icmp
- Description: Allow ping test
- VPC: Select the above VPC
- Inbound rules:
  - Add rule: 
    - Type: All ICMP - IPv4
    - Source: Anywhere-IPv4

### Configure HA VPN connections
#### Create a cloud router on GCP
- Name: kimy-cloud-router
- Network: select kimy-net-00
- Region: select asia-northeast3
- Google ASN: 65530
  - Note: You can use any private ASN (64512 - 65534, 4200000000 - 4294967294) that you are not using elsewhere in your network
- Advertised routes
  - Routes: Advertise all subnets visible to the Cloud Router (Default)

**!!! Take notes !!!**
`Google ASN`은 AWS에서 customer gateways를 만들 때 사용될 것이다.

#### Create a VPN gateway on GCP
- (VPN options: High-availability (HA) VPN)
- VPN gateway name: kimy-vpn-gw
- Network: select kimy-net-00
- Region: select asia-northeast3 (Seoul)

**!!! Take notes !!!**
VPN gateway가 생성되면서 2개의 인터페이스가 생성된다.
이는 AWS에서 customer gateway를 만들 때 사용될 것이다.

#### Create 2 customer gateways on AWS
- Customer gateway 1
  - Name tag: kimy-customer-gateway-00
  - BGP ASN: input the above Google ASN (65530)
  - IP Address: 34.64.65.61
- Customer gateway 2
  - Name tag: kimy-customer-gateway-01
  - BGP ASN: input the above Google ASN (65530)
  - IP Address: 34.64.130.247

#### Create a virtual private gateway on AWS
- Name tag: kimy-vpgw
- Autonomous System Number (ASN): Amazon default ASN
(After creation)
- Click Actions to attach to VPC
  - Available VPCs: select kimy-net-00
**Note - It will take time to attach**

#### Create site-to-site VPN connections on AWS
- Site-to-stie VPN connection 1
  - Name tag: kimy-vpn-conn-00
  - Target gateway type: Virtual private gateway
  - Virutal private gateway: select kimy-vpgw
  - Customer ateway: Existing
  - Customer gateway ID: select kimy-customer-gateway-00
  - Routing options: Dynamic (requires BGP)

- Site-to-site VPN connection 2
  - Name tag: kimy-vpn-conn-01
  - Target gateway type: Virtual private gateway
  - Virutal private gateway: select kimy-vpgw
  - Customer ateway: Existing
  - Customer gateway ID: select kimy-customer-gateway-01
  - Routing options: Dynamic (requires BGP)

Note - It takes some time to become available state.
#### Download configurations of site-to-site VPN connections on AWS

- Vendor: Generic
- Platform: Generic
- Software: Vendor Agnostic
- IKE version: ikev2

#### Add VPN tunnels on GCP
- Name: kimy-peer--vpn-gateway
- Peer VPN gateway interface
  - Interface: four interfaces
  - Input **Virtual Private Gateway IPs of Outside IP Addresses** in the downloaded configuration
    - Interface 0 IP address: xxx
    - Interface 1 IP address: xxx
    - Interface 2 IP address: xxx
    - Interface 3 IP address: xxx
- Cloud Router: select kimy-cloud-router-multicloud-vpn
- VPN tunnels:
  - Edit VPN tunnel:
    - Associated peer VPN gateway interface: 0
    - Name: kimy-tunnel-00
    - IKE version: IKEv2
    - IKE pre-shared key: input a IKE pre-shared key in the downloaded configuration
  - Edit VPN tunnel:
    - Associated peer VPN gateway interface: 1
    - Name: kimy-tunnel-01
    - IKE version: IKEv2
    - IKE pre-shared key: input a IKE pre-shared key in the downloaded configuration
  - Edit VPN tunnel:
    - Associated peer VPN gateway interface: 2
    - Name: kimy-tunnel-02
    - IKE version: IKEv2
    - IKE pre-shared key: input a IKE pre-shared key in the downloaded configuration
  - Edit VPN tunnel:
    - Associated peer VPN gateway interface: 3
    - Name: kimy-tunnel-03
    - IKE version: IKEv2
    - IKE pre-shared key: input a IKE pre-shared key in the downloaded configuration
(After creating tunnel-01 ~ 04)
- Click "configure BGP SESSION" of tunnel-01
  - Name: kimy-bgp-00
  - Peer ASN: input a Peer ASN n the download configuration (64512) <- 4개 모두 같음
  - Allocate BGP IPv4 addres: Manually
  - Cloud Router BGP IPv4 address: input **the customer gateway (without prefix /30) of Inside IP addresses** in the downloaded configuration 
  - BGP peer IPv4 address: input **the Virtual Private Gateway (without prefix /30) of Inside IP addresses** in the downloaded configuration
  
(Check VPN tunnel status and GCP status)

BGP session status가 "Waiting for peer"이다 ㅠㅠ (뭔가 세팅을 잘못 했겠지...)

![](../../assets/images/231010-issue-of-BGP-session-status.png)

Q: GCP에서 4개의 VPN tunnels를 필요로 하는 이유는?

일단 여기까지! 리소스 삭제는 역순으로!

### Test the configuration by ping
#### Create a VM instance in GCP
- Name: kimy-vm-multi-cloud-vpn
- Region: asia-northeast3 (Seoul)
- Zone: asia-northeast3-a
- Machie configuration:
  - General purpose
  - Series: E2
  - Machine type:
    - Preset
    - e2-medium (2 vCPU, 1 core, 4 GB memory)
   - Availability policies:
     - VM provisioning model: Standard
  - Display device: unchecked
- Confidnetial VM service: N/A 
- Container: N/A
- Boot disk
  - Ubuntu 20.04
- Identity and API access
  - Service account: Compute Engin default service account
- Access scopes: Allow default access
- Firewall: Unchecked
- Observability - Ops Agent: N/A
- Advanced options:
  - Networking: 
    - Network interfaces:
      - Edit network interface:
        - Network: kimy-vpc-multicloud-vpn
        - Subnetwork: kimy-subnet-multi-cloud-vpn IPv4 (102.168.0.0/24)
        - IP stack type: IPv4 (single-stack)
        - Primary  internal IPv4 address: Ephemeral (Automatic)
        - Alias IP ranges: N/A
        - External IPv4 address: Ephemeral
        - Network Service Tier: Premium
        - Public DNS PTR Record: Unchecked

#### Create an instance in aws
- Name: kimy-instance-multicloud-vpn
- Application and OS Images: Ubuntu 20.04 LTS
- Instance types: t2.micro
- Key pair: Create new key pair (multicloud-vpn)
- Network settings:
  - VPC: select kimy-multicloud-vpn-vpc
  - Subnet: select kimy-multi-cloud-vpn-subnet-aprivate1-ap-northeast-2a
  - Auto-assign public IP: Disable
  - Firewall (security groups):
    - Select existing security group
    - kimy-multicloud-vpn-sg
- Storage (volumes)
  - EBS Volumes:
    - Size: 10 (GiB)
    - Volume type: gp2
### Referecnes
* [자동화된 네트워크 배포: Terraform으로 Google Cloud 및 AWS 간 VPN 빌드](https://cloud.google.com/architecture/automated-network-deployment-multicloud?hl=ko) on October 24, 2017 by Google Cloud
* [Terraform examples for HA VPN gateways](https://cloud.google.com/network-connectivity/docs/vpn/how-to/automate-vpn-setup-with-terraform#to_an_external_peer_network) on October 9, 2023 by Google Cloud
* [[GCP #11] AWS와 GCP 간의 HA VPN 연결](https://blog.naver.com/PostView.naver?blogId=blueday9404&logNo=223055342609) on March 25, 2023 by IT Blue
* [Visual Subnet Calculator](https://www.davidc.net/sites/default/subnets/subnets.html)



