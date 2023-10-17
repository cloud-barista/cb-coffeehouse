
#### Private IPv4 addresses

The [Internet Engineering Task Force](https://en.wikipedia.org/wiki/Internet_Engineering_Task_Force "Internet Engineering Task Force") (IETF) has directed the [Internet Assigned Numbers Authority](https://en.wikipedia.org/wiki/Internet_Assigned_Numbers_Authority "Internet Assigned Numbers Authority") (IANA) to [reserve](https://en.wikipedia.org/wiki/Reserved_IP_addresses "Reserved IP addresses") the following IPv4 address ranges for private networks:[[1]](https://en.wikipedia.org/wiki/Private_network#cite_note-rfc1918-1): 4 

|RFC 1918 name|IP address range|Number of addresses|Largest [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing "Classless Inter-Domain Routing") block (subnet mask)|Host ID size|Mask bits|_[Classful](https://en.wikipedia.org/wiki/Classful_network "Classful network")_ description[[Note 1]](https://en.wikipedia.org/wiki/Private_network#cite_note-4)|
|---|---|---|---|---|---|---|
|24-bit block|10.0.0.0 – 10.255.255.255|16777216|10.0.0.0/8 (255.0.0.0)|24 bits|8 bits|single class A network|
|20-bit block|172.16.0.0 – 172.31.255.255|1048576|172.16.0.0/12 (255.240.0.0)|20 bits|12 bits|16 contiguous class B networks|
|16-bit block|192.168.0.0 – 192.168.255.255|65536|192.168.0.0/16 (255.255.0.0)|16 bits|16 bits|256 contiguous class C networks|

In practice, it is common to subdivide these ranges into smaller [subnets](https://en.wikipedia.org/wiki/Subnet "Subnet").

#### Dedicated space for carrier-grade NAT deployment

Main article: [IPv4 shared address space](https://en.wikipedia.org/wiki/IPv4_shared_address_space "IPv4 shared address space")

In April 2012, IANA allocated the _100.64.0.0/10_ block of IPv4 addresses specifically for use in [carrier-grade NAT](https://en.wikipedia.org/wiki/Carrier-grade_NAT "Carrier-grade NAT") scenarios.[[4]](https://en.wikipedia.org/wiki/Private_network#cite_note-rfc6598-5)

|IP address range|Number of addresses|Largest [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing "Classless Inter-Domain Routing") block (subnet mask)|Host ID size|Mask bits|
|---|---|---|---|---|
|100.64.0.0 – 100.127.255.255|4194304|100.64.0.0/10 (255.192.0.0)|22 bits|10 bits|

This address block should not be used on private networks or on the public Internet. The size of the address block was selected to be large enough to uniquely number all customer access devices for all of a single operator's [points of presence](https://en.wikipedia.org/wiki/Points_of_presence "Points of presence") in a large metropolitan area such as [Tokyo](https://en.wikipedia.org/wiki/Tokyo "Tokyo").[[4]](https://en.wikipedia.org/wiki/Private_network#cite_note-rfc6598-5)

#### Network prefix size and number of hosts

| Network prefix size | Number of hosts |
|:-------------------:|:---------------:|
|          8          |   16,777,214    |
|         12          |    1,048,574    |
|         16          |     65,534      |
|         24          |       254       |

Reference:
 - [Private network - Wikipedia](https://en.wikipedia.org/wiki/Private_network)