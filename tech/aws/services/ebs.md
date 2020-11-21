# Elastic Block Store

Allows you to attach block to your EC2 instances.
Although they look like block devices directly attached to the instance, they are attached over the network.
There are EBS optimized instance types.

EBS volumes reside inside an AZ.

## Snapshots

You can make a point-in-time image of the EBS volume.
The image is automatically replicated within the region.
