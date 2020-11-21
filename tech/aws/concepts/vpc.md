# Virtual Private Cloud (VPC)

Amazon VPC provides logically isolated networks within your account.
A VPC can span over all the Availability Zones within a region.
Per default communication is only allowed to instances within the same VPC.
You have to explicitly enable connections to communicate with other networks:

- **Internet Gateway**: Allows outbound and bound connections to the internet
- **Egress Only Internet Gateway**: Allows only outbound connection and corresponding responses
- **Virtual Private Gateway**: Allows to establish a VPN connection
- **Amazon VPC Endpoints**: Connects to AWS servies without traversing an internet gateway
- **Amazon VPC Peering**: Connects two VPCs
- **AWS Transit Gateway**: Centrally manage connectivity between many VPCs and on-premises environment

## Subnets

Within a VPC you can define one or more subnets.
A subnet is associated to an Availability Zone within the region.
Each subnet has its block of private IP adressess. 
Those blocks are a subset of the overall IP address range assigned to the VPC.
