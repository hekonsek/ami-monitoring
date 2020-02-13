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

### Enabling EC2 service discovery

If you would like your Prometheus to collect EC2 instances metrics automatically, you need to add EC2 read permissions to your
monitoring EC2 machine.

First of all create role dedicated for Prometheus EC2 node to discover other EC2 instanced in your EC2 account:

```
$ cat - > trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}

$ aws iam create-role --role-name=prometheus-ec2-sd --assume-role-policy-document file://trust-policy.json
$ aws iam attach-role-policy --role-name=prometheus-ec2-sd --policy-arn=arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess
```

Then associate this new role you created with your monitoring EC2 node:

```
$ aws iam create-instance-profile --instance-profile-name prometheus-ec2-sd
$ aws iam add-role-to-instance-profile --role-name prometheus-ec2-sd --instance-profile-name prometheus-ec2-sd
$ aws ec2 associate-iam-instance-profile --instance-id YOUR-MONITORING-EC2-INSTANCE-ID --iam-instance-profile Name=prometheus-ec2-sd
```

## License

This project is distributed under [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0.html).