# Elastic Compute Cloud (EC2)

Enables you to provision environments called _instances_. 
You have the flexibility to choose the hardware resources you need.
You are in control of the OS and networking.

An EC2 instance runs within an Availability Zone.

## Instance Types

- **General purpose**: Balanced CPU and RAM
- **Compute optimized**: High amount of CPU 
- **Memory optimized**: Large amount of RAM
- **Storage optimized**: Large amount of I/O throughput
- **Accelerated computing**: e.g. FPGAs or GPUs

To change the hardware allocation, you have to stop the instance.

## Storage

You can attach [EBS](ebs.md) block devices to your instance.
Certain instance types allow you to mount an _instance volume_.
This storage is great for high performance storage or caches.
It's lifetime is coupled with the EC2 instance:

- The data persists a restart
- The data is deleted upon termination

## Networking

Virtual network interfaces called _elastic network interfaces_ provide networking for you EC2 instance.
Each EC2 instance has a _primary network interface_ attached to it.
A _security group_ acts as a stateful firewall.

## Provisioning

You can specify _user data_ to run a shell script at the start of an instance.
You can access properties of the running instance via the _instance metadata service_ (IMDS).
It listens to HTTP requests at 169.254.269.254.

```
curl 169.254.169.154/latest/meta-data
curl 169.254.169.154/latest/user-data
```

## Monitoring

CPU and disk utilization is automatically monitored and can be accessed via _CloudWatch_.
To access memory utilization you have to install the _CloudWatch agent_ on the instance.
