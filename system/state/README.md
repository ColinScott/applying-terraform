State
=====

This project creates the necessary resources for each environment to support Terraform remote state using S3 and DynamoDB.

As this project creates the resources for storing state it cannot itself store its state remotely. As Terraform does not currently support interpolation in remote state declaration this is isn't actually an inconvenience for most uses.