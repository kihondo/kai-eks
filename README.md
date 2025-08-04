# Provision an EKS Cluster using Terraform
* This repo contains Terraform files to provision an EKS cluster on AWS.

### Terraform Providers used in this project
* `source  = "hashicorp/aws"`
    * `version = "~> 5.47.0"` # Apr 26, 2024

* `source  = "hashicorp/random"`
    * `version = "~> 3.6.1"` # Apr 16, 2024

* `source  = "hashicorp/tls"`
    * `version = "~> 4.0.5"` # Nov 28, 2023

* `source  = "hashicorp/cloudinit"`
    * `version = "~> 2.3.4"` # Apr 22, 2024

### Terraform Modules used in this project
* `source  = "terraform-aws-modules/vpc/aws"`
    * `version = "5.8.1"` # Apr 26, 2024 (https://github.com/terraform-aws-modules/terraform-aws-vpc/tree/v5.8.1)
        * main.tf (https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/v5.8.1/main.tf)
        * variables.tf (https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/v5.8.1/variables.tf)
        * outputs.tf (https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/v5.8.1/outputs.tf)

* `source  = "terraform-aws-modules/eks/aws"`
    * `version = "20.8.5"` # Apr 9, 2024 (https://github.com/terraform-aws-modules/terraform-aws-eks/tree/v20.8.5)
        * main.tf (https://github.com/terraform-aws-modules/terraform-aws-eks/blob/v20.8.5/main.tf)
        * node_groups.tf (https://github.com/terraform-aws-modules/terraform-aws-eks/blob/v20.8.5/node_groups.tf)
        * variables.tf (https://github.com/terraform-aws-modules/terraform-aws-eks/blob/v20.8.5/variables.tf)
        * outputs.tf (https://github.com/terraform-aws-modules/terraform-aws-eks/blob/v20.8.5/outputs.tf)

### How to access EKS cluster
* Run the following command to retrieve the access credentials for your cluster and configure kubectl
```
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```