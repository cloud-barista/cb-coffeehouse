
## Multi-cloud network configuration by HA VPN connections

In this article, I'd like to share a brief idea about how to configure multi-cloud network by high availability (HA) virtual private network (VPN) connections.

Related articles:
- [sample-design-for-multi-cloud-network-configuration](sample-design-for-multi-cloud-network-configuration.md)
- [resources-related-to-configure-multi-cloud-network](resources-related-to-configure-multi-cloud-network.md)
### Multi-cloud network configuration

I will configure multi-cloud network between Google Cloud Platform (GCP) and Amazon Web Service (AWS). This will enable direct communication between VPC networks on both cloud platforms.

#### Create a VPC network with 2 subnets on GCP

Form
![](../../assets/images/configure-multi-cloud-network/231012-01-Form-to-create-a-VPC-network-and-subnets-on-GCP.png)

Created VPC and subnets
![](../../assets/images/configure-multi-cloud-network/231012-02-Created-VPC-network-and-subnets-on-GCP.png)


#### Create a VPC and 2 subnets on AWS

Form
![](../../assets/images/configure-multi-cloud-network/231012-03-Form-to-create-a-VPC-on-AWS.png)

Form
![](../../assets/images/configure-multi-cloud-network/231012-04-Form-to-create-2-subnets-on-AWS.png)

Created VPC and networks
![](../../assets/images/configure-multi-cloud-network/231012-05-Created-VPC-and-subnets-on-AWS.png)


#### Create a Security Group

Form
![](../../assets/images/configure-multi-cloud-network/231012-06-Form-to-create-a-security-group-on-AWS.png)

Created security group
![](../../assets/images/configure-multi-cloud-network/231012-07-Created-security-group-on-AWS.png)


#### Create a Cloud Router on GCP

Form
![](../../assets/images/configure-multi-cloud-network/231012-08-Form-to-create-a-Cloud-Router-on-GCP.png)

Created Cloud Router
![](../../assets/images/configure-multi-cloud-network/231012-09-Created-Cloud-Router-on-GCP.png)

**!!! Take notes !!!**
`Google ASN` is going to be used to create customer gateways on AWS.

#### Create a Cloud VPN gateway on GCP

Form
![](../../assets/images/configure-multi-cloud-network/231012-10-Form-to-create-a-Cloud-VPN-gateway-on-GCP.png)

Created Cloud VPN gateway
![](../../assets/images/configure-multi-cloud-network/231012-11-Created-Cloud-VPN-gateway-on-GCP.png)

**!!! Take notes !!!**
IP addresses of two interfaces (i.e., `Interface: 0` and `Interface:1`) are going to be used to create customer gateways on AWS.


#### Create 2 customer gateways on AWS

Form of customer gateway 1 of 2
![](../../assets/images/configure-multi-cloud-network/231012-12-Form-to-create-customer-gateway-1-of-2-on-AWS.png)

Form of customer gateway 2 of 2
![](../../assets/images/configure-multi-cloud-network/231012-13-Form-to-create-customer-gateway-2-of-2-on-AWS.png)

Created customer gateways
![](../../assets/images/configure-multi-cloud-network/231012-14-Created-customer-gateways-on-AWS.png)


#### Create a virtual private gateway

Form
![](../../assets/images/configure-multi-cloud-network/231012-15-Form-to-create-a-virtual-private-gateway-on-AWS.png)

Created virtual private gateway
![](../../assets/images/configure-multi-cloud-network/231012-16-Created-virtual-private-gateway-on-AWS.png)

Form of attach to VPC
![](../../assets/images/configure-multi-cloud-network/231012-17-Form-to-attach-the-virtual-private-gateway-to-VPC-on-AWS.png)

Attached virtual private gateway
![](../../assets/images/configure-multi-cloud-network/231012-18-Attached-virtual-private-gateway-on-AWS.png)

Note - It takes some time to attach.

#### Create site-to-site VPN connnections on AWS

Form of site-to-site VPN connection 1 of 2
![](../../assets/images/configure-multi-cloud-network/231012-19-Form-to-create-site-to-site-VPN-connection-1-of-2-on-AWS.png)

Form of site-to-site VPN connection 2 of 2
![](../../assets/images/configure-multi-cloud-network/231012-20-Form-to-create-site-to-site-VPN-connection-2-of-2-on-AWS.png)

Created site-to-site VPN connections
![](../../assets/images/configure-multi-cloud-network/231012-21-Created-site-to-site-VPN-connections-on-AWS.png)

Note - It takes some time to become available state.

#### Download configuration of site-to-site VPN connections on AWS

Location (select connection > click download configuration)
![](../../assets/images/configure-multi-cloud-network/231012-22-Location-to-download-configurations-of-site-to-site-VPN-connnections-on-AWS.png)

Form of downalod configuration
![](../../assets/images/configure-multi-cloud-network/231012-23-Form-to-download-configuration-on-AWS.png)

Downloaded configurations
![](../../assets/images/configure-multi-cloud-network/231012-24-Downloaded-configurations.png)

Note - It will be used to establish VPN tunnels on GCP

#### Add VPN tunnels on GCP

![](../../assets/images/configure-multi-cloud-network/231012-25-Location-to-add-VPN-tunnel-on-GCP.png)

![](../../assets/images/configure-multi-cloud-network/231012-26-Form-to-add-VPN-tunnels-on-GCP.png)

Form to add a peer VPN gateway
![](../../assets/images/configure-multi-cloud-network/231012-27-Form-to-create-a-peer-VPN-gateway-on-GCP.png)

In the 2 downloaded files on AWS, I can find 4 IP Addresses of Virtual Private Gateway. Please see below.
![](../../assets/images/configure-multi-cloud-network/231012-33-Downloaded-configuration-to-create-peer-VPN-interfaces.png)

Form to edit VPN tunnels 
![](../../assets/images/configure-multi-cloud-network/231012-29-Form-to-edit-VPN-tunnels-on-GCP.png)

In the 2 downloaded files on AWS, I can find 4 Pre-Shared Keys. Please see below.
![](../../assets/images/configure-multi-cloud-network/231012-30-Downloaded-configuration-to-edit-VPN-tunnels.png)

Configure BGP sessions 
![](../../assets/images/configure-multi-cloud-network/231012-31-Location-to-configure-BGP-sessions-on-GCP.png)

Configure a BGP session for kimy-tunnel-00
![](../../assets/images/configure-multi-cloud-network/231012-32-Form-to-create-BGP-session-on-GCP.png)
Repeat this for kimy-tunnel-01, kimy-tunnel-02, and kimy-tunnel-03

In the 2 downloaded files on AWS, I can find
- Customer Gateway IP address to assign as Cloud Router BGP IPv4 address,
- Virtual Private Gateway to assign as BGP peer IPv4 address, and
- Virtual Prrivate Gateway ASN to assign Peer ASN.

![](../../assets/images/configure-multi-cloud-network/231012-28-Download-configuration-to-configure-BGP-sessions.png)

Added VPN tunnels
![](../../assets/images/configure-multi-cloud-network/231012-34-Summary-and-reminder-of-cloud-VPN-tunnels-on-GCP.png)

#### Check routes on GCP
Routing rules are automatically registered.
![](../../assets/images/configure-multi-cloud-network/231012-35-Routes-on-GCP.png)

#### Check route tables on AWS

Edit route propagation
![](../../assets/images/configure-multi-cloud-network/231012-36-Location-to-edit-route-propagation-on-AWS.png)

![](../../assets/images/configure-multi-cloud-network/231012-37-Form-to-edit-route-propagation-on-AWS.png)

Propagated rules
![](../../assets/images/configure-multi-cloud-network/231012-38-Route-on-AWS.png)


### Multi-cloud network verification

Verification is performed through a ping test between two virtual machines.
#### Create an instance on AWS

![](../../assets/images/configure-multi-cloud-network/231012-39-Created-instance-on-AWS.png)

#### Create a VM instance on GCP

![](../../assets/images/configure-multi-cloud-network/231012-40-Created-VM-instance-on-GCP.png)

#### Add firewall rule on GCP
Allow to 22 to access VM instnace by GCP SSH-in-browser
![](../../assets/images/configure-multi-cloud-network/231012-41-Added-firewall-rule-to-allow-22.png)

#### Ping test

VM instance on GCP
![](../../assets/images/configure-multi-cloud-network/231012-42-Ping-test-result.png)

Cool~~~

### Clean up all resources
Proceed in reverse order of creation

1. Remove firewall rules
2. Remove instances
3. Diable route propagation on AWS
4. Delete Cloud VPN tunnels on GCP
5. Delete peer VPN gateway on GCP
6. Delete site-to-stie VPN connections on AWS
7. Detach the virtual private gateway from the VPC on AWS
8. Delete the virtual private gateway on AWS
9. Delete customer gateways on AWS
10. Delete Cloud VPN gateway on GCP
11. Delete Cloud Router on GCP
12. Delete security group on AWS
13. Delete subnets on AWS
14. Delete VPC on AWS
15. Delete VPC and subnets on GCP

That's it :-)


#### References
* [자동화된 네트워크 배포: Terraform으로 Google Cloud 및 AWS 간 VPN 빌드](https://cloud.google.com/architecture/automated-network-deployment-multicloud?hl=ko) on October 24, 2017 by Google Cloud
* [Terraform examples for HA VPN gateways](https://cloud.google.com/network-connectivity/docs/vpn/how-to/automate-vpn-setup-with-terraform#to_an_external_peer_network) on October 9, 2023 by Google Cloud
* [[GCP #11] AWS와 GCP 간의 HA VPN 연결](https://blog.naver.com/PostView.naver?blogId=blueday9404&logNo=223055342609) on March 25, 2023 by IT Blue