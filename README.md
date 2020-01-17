<div align="center">
    <img src="https://raw.githubusercontent.com/binbashar/bb-devops-tf-aws-organizations/master/figures/binbash.png" alt="drawing" width="350"/>
</div>
<div align="right">
  <img src="https://raw.githubusercontent.com/binbashar/bb-devops-tf-aws-organizations/master/figures/binbash-leverage-terraform.png"
  alt="leverage" width="230"/>
</div>

# Reference Architecture: Terraform AWS Organizations Account Baseline

## Overview
This repository contains all Terraform configuration files used to create Binbash Leverage Reference AWS Cloud 
Solutions Architecture.

## Files/Folders Organization
The following block provides a brief explanation of the chosen AWS Organization Accounts layout:
```
+ devstg/             (resources for dev apps/services account)
    ...
+ prod/             (resources for prod apps/services account)
    ...
+ root-org/        (resources for the root-org account)
    ...
+ security/        (resources for the security + users account)
    ...
+ shared/          (resources for the shared account)
    ...
+ legacy/          (resources for the legacy/pre-existing account)
    ...
```

<div align="center">
  <img src="https://raw.githubusercontent.com/binbashar/bb-devops-tf-aws-organizations/master/figures/binbash-aws-organizations.png"
alt="leverage" width="1000"/>
</div>
**NOTE:** *Image just as reference*


Our default AWS Organizations terraform layout solution includes 5 accounts (6 or N if you invite a pre-existing AWS Account), 


| Account                     | Description                                                                                                                                                                                                                                                                                |
|-----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Root Organizations          | Used to manage configuration and access to AWS Org managed accounts. The AWS Organizations account provides the ability to create and financially manage member accounts, it contains AWS Organizations Service Control Policies(SCPs).                                                    |
| Shared Services / Resources | Reference for creating infrastructure shared services such as directory services, DNS, VPN Solution, Monitoring tools like Prometheus and Graphana, CI/CD server (Jenkins, Drone, Spinnaker, etc), centralized logging solution like ELK  and Vault Server (Hashicorp Vault)               |
| Security                    | Intended for centralized user mamangement via IAM roles based cross-org auth approach (IAM roles per account to be assumed still needed. Also to centralize AWS CloudTrail and AWS Config logs, and used as the master AWS GuardDuty Account                                               |
| Legacy                      | Your pre existing AWS Accounts to be invited as memebers of the new AWS Organization, probably several services and workloads are going to be progressively migrated to your new Accounts.                                                                                                 |
| Apps DevStg                 | Host your DEV, QA and STG environment workloads Compute / Web App Servers (K8s Clusters and Lambda Functions), Load Balancers, DB Servers, Caching Services, Job queues & Servers, Data, Storage, CDN                                                                                      |
| Apps Prod                   | Host your PROD environment workloads Compute / Web App Servers (K8s Clusters and Lambda Functions), Load Balancers, DB Servers, Caching Services, Job queues & Servers, Data, Storage, CDN                                                                                                 |


## Read more

### Why you should use AWS Organizations? (https://aws.amazon.com/organizations/) 
- **Billing:** Consolidated billing for all your accounts within organization, enhanced per account cost 
filtering and RI usage (https://aws.amazon.com/about-aws/whats-new/2019/07/amazon-ec2-on-demand-capacity-reservations-shared-across-multiple-aws-accounts/)  
- **Security I:** Extra security layer: You get fully isolated infrastructure for different organizations 
units in your projects, eg: Dev, Prod, Shared Resources, Security, Users, BI, etc.
- **Security II:** Using AWS Organization you may use Service Control Policies (SCPs) to control which 
AWS services are available within different accounts.
- **Networking:** Connectivity and access will be securely setup via VPC peering + NACLS + Sec Groups
 everything with private endpoints only accessible vía Pritunl VPN significantly reducing the surface of attack.
- **User Mgmt:** You can manage all your IAM resources (users/groups/roles) and policies in one 
place (usually, security/users account) and use AssumeRole to works with org accounts.
- **Operation:** Will reduce the **blast radius** to the maximum possible.   
- **Compatibility:** Legacy accounts can be invited as a member of the new Organization.



Consider the following AWS official links as reference since the AWS Organization structure:

- **AWS Multiple Account Security Strategy:** https://aws.amazon.com/answers/account-management/aws-multi-account-security-strategy/
- **AWS Multiple Account Billing Strategy:** https://aws.amazon.com/answers/account-management/aws-multi-account-billing-strategy/
- **Authentication and Access Control for AWS Organizations:** 
https://docs.aws.amazon.com/organizations/latest/userguide/orgs_permissions.html (keep in mind EC2 and other services can also use AWS IAM Roles to get secure cross-account access - https://security.stackexchange.com/questions/205698/security-audit-on-aws-question-on-findings/206576#206576)



## TODO

Develop a Terraform 0.12 compatible module: `terraform-aws-organizations` https://registry.terraform.io/modules/binbashar

---

# Release Management

## Docker based makefile commands

* <https://cloud.docker.com/u/binbash/repository/docker/binbash/git-release>
* <https://github.com/binbashar/bb-devops-tf-aws-organizations/blob/master/Makefile>

Root directory `Makefile` has the automated steps (to be integrated with **CircleCI jobs** []() )

### CircleCi PR auto-release job

<div align="left">
  <img src="https://raw.githubusercontent.com/binbashar/bb-devops-tf-aws-organizations/master/figures/circleci.png" alt="leverage-circleci" width="230"/>
</div>

- <https://circleci.com/gh/binbashar/bb-devops-tf-aws-organizations>
- **NOTE:** Will only run after merged PR.

### Manual execution from workstation

```
$ make
Available Commands:
 - release-major-with-changelog make changelog-major && git add && git commit && make release-major
 - release-minor-with-changelog make changelog-minor && git add && git commit && make release-minor
 - release-patch-with-changelog make changelog-patch && git add && git commit && make release-patch
