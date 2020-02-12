# Monitoring AMI

Golden AMI image of monitoring machine.

Image includes:
- Prometheus server
  - collecting metrics for monitoring machine itself
  - EC2 service discovery
- Docker server

## Usage

Current version of Kafka AMI is `0.2.0` (AMI id `ami-0a3fb87f415c833b9`). In order to create new Kafka EC2 instance
execute the following AWS CLI command:

```
$ aws ec2 run-instances --region=us-east-1 --image-id ami-0a3fb87f415c833b9 --instance-type m5.large \\ 
  --tag-specifications='ResourceType=instance,Tags=[{Key=Name,Value=monitoring}]' \\
  --key-name default
```

## License

This project is distributed under Apache 2 license.