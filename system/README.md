Example System
==============

The example system shows how you can stand up a complete environment using Terraform. It does not follow best practice for setting up an AWS environment so don't use it and expect to have a complete and secure AWS environment at the end. It can be used as a skeleton to build such a thing if you already know how to do that.

Components
----------

### Level 0

__state__ creates an S3 bucket for storing Terraform state files and a DynamoDB table for locking support.

### Level 1