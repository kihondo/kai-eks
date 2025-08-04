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

### You can verify with `terraform providers`
```
$ terraform providers

Providers required by configuration:
.
├── provider[registry.terraform.io/hashicorp/aws] ~> 5.47.0
├── provider[registry.terraform.io/hashicorp/random] ~> 3.6.1
├── provider[registry.terraform.io/hashicorp/tls] ~> 4.0.5
├── provider[registry.terraform.io/hashicorp/cloudinit] ~> 2.3.4
├── module.eks
│   ├── provider[registry.terraform.io/hashicorp/tls] >= 3.0.0
│   ├── provider[registry.terraform.io/hashicorp/time] >= 0.9.0
│   ├── provider[registry.terraform.io/hashicorp/aws] >= 5.40.0
│   ├── module.eks_managed_node_group
│   │   ├── provider[registry.terraform.io/hashicorp/aws] >= 5.40.0
│   │   └── module.user_data
│   │       ├── provider[registry.terraform.io/hashicorp/cloudinit] >= 2.0.0
│   │       └── provider[registry.terraform.io/hashicorp/null] >= 3.0.0
│   ├── module.fargate_profile
│   │   └── provider[registry.terraform.io/hashicorp/aws] >= 5.40.0
│   ├── module.kms
│   │   └── provider[registry.terraform.io/hashicorp/aws] >= 4.33.0
│   └── module.self_managed_node_group
│       ├── provider[registry.terraform.io/hashicorp/aws] >= 5.40.0
│       └── module.user_data
│           ├── provider[registry.terraform.io/hashicorp/cloudinit] >= 2.0.0
│           └── provider[registry.terraform.io/hashicorp/null] >= 3.0.0
└── module.vpc
    └── provider[registry.terraform.io/hashicorp/aws] >= 5.30.0

Providers required by state:

    provider[registry.terraform.io/hashicorp/aws]

    provider[registry.terraform.io/hashicorp/null]

    provider[registry.terraform.io/hashicorp/random]

    provider[registry.terraform.io/hashicorp/time]

    provider[registry.terraform.io/hashicorp/tls]
```

### How to access EKS cluster
* Run the following command to retrieve the access credentials for your cluster and configure kubectl
```
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```
* You can also verify
    *  `cat ~/.kube/config`
    * `kubectl config get-contexts`

* Verify your EKS cluster
```
$ kubectl get nodes -o wide
NAME                                            STATUS   ROLES    AGE     VERSION               INTERNAL-IP   EXTERNAL-IP   OS-IMAGE                       KERNEL-VERSION                    CONTAINER-RUNTIME
ip-10-0-2-88.ap-southeast-1.compute.internal    Ready    <none>   5m31s   v1.33.0-eks-802817d   10.0.2.88     <none>        Amazon Linux 2023.8.20250707   6.1.141-165.249.amzn2023.x86_64   containerd://1.7.27
ip-10-0-3-105.ap-southeast-1.compute.internal   Ready    <none>   5m25s   v1.33.0-eks-802817d   10.0.3.105    <none>        Amazon Linux 2023.8.20250707   6.1.141-165.249.amzn2023.x86_64   containerd://1.7.27
```

```
$ kubectl get svc -o wide -A
NAMESPACE     NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE   SELECTOR
default       kubernetes                  ClusterIP   172.20.0.1       <none>        443/TCP                  12m   <none>
kube-system   eks-extension-metrics-api   ClusterIP   172.20.168.183   <none>        443/TCP                  12m   <none>
kube-system   kube-dns                    ClusterIP   172.20.0.10      <none>        53/UDP,53/TCP,9153/TCP   10m   k8s-app=kube-dns
```
* Verify any CRDs installed
```
$ kubectl get crds
NAME                                         CREATED AT
cninodes.vpcresources.k8s.aws                2025-08-04T06:50:53Z
eniconfigs.crd.k8s.amazonaws.com             2025-08-04T06:52:54Z
policyendpoints.networking.k8s.aws           2025-08-04T06:50:53Z
securitygrouppolicies.vpcresources.k8s.aws   2025-08-04T06:50:53Z
```