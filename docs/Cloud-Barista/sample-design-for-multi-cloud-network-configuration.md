### Sample design for multi-cloud network configuration

Related articles:
- [private-ipv4-addresses](private-ipv4-addresses.md)
#### Design global network
I assume the most extensive network is 192.168.0.0/16 logically.
This will be divided and used to build a multi-cloud network as shown below.
- 192.168.0.0/18 (CIDR block to be used in GCP)
- 192.168.64.0/18 (CIDR block to be used in AWS)
- 192.168.128.0/18 (CIDR block to be used in Azure)
- 192.168.192.0/18 (reserved)

#### Design network for GCP
The GCP network configuration scenario is as follows.
- Available network CIDR block is 192.168.0.0/18.
- 4 subnets are configured, and each can accommodate 254 hosts.
- Among them, two are private subnets and the remaining two are public subnets.

Therefore, the network can be configured as follows.
- Subnet 1: 192.168.0.0/24 (public subnet)
- Subnet 2: 192.168.1.0/24 (private subnet)
- Subnet 3: 192.168.2.0/24 (reserved) 
- Subnet 4: 192.168.3.0/24 (reserved)

The CIDR block that can include subnets is 192.168.0.0/22. **BUT! GCP has no CIDR block for VPC network.**

#### Design network for AWS
The AWS network configuration scenario is as follows (similar to GCP).
- Available network CIDR block is 192.168.64.0/18.
- 4 subnets are configured, and each can accommodate 254 hosts.
- Among them, two are private subnets and the remaining two are public subnets.

Therefore, the network can be configured as follows.
- Subnet 1: 192.168.64.0/24 (public subnet)
- Subnet 2: 192.168.65.0/24 (private subnet)
- Subnet 3: 192.168.66.0/24 (not used yet)
- Subnet 4: 192.168.67.0/24 (not used yet)

The CIDR block that can include subnets is 192.168.64.0/22. Thus, VPC can have CIDR block, 192.168.64.0/22.

#### Design network for Azure
The Azure network configuration scenario is as follows (similar to GCP).
- Available network CIDR block is 192.168.128.0/18.
- 4 subnets are configured, and each can accommodate 254 hosts.
- Among them, two are private subnets, one is GatewaySubnet, and the remaining one is a public subnet.

Therefore, the network can be configured as follows.
- Subnet 1: 192.168.128.0/24 (public subnet)
- Subnet 2: 192.168.129.0/24 (private subnet)
- Subnet 3: 192.168.130.0/24 (GatewaySubnet)
- Subnet 4: 192.168.131.0/24 (not used yet)

The CIDR block that can include subnets is 192.168.128.0/22. Thus, VPC can have CIDR block, 192.168.128.0/22.

#### References
* [Visual Subnet Calculator](https://www.davidc.net/sites/default/subnets/subnets.html)
