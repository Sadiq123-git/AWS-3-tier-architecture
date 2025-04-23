multi-tier-terraform/
│
├── main.tf         # Main logic (like EC2, ALB, AutoScaling)
├── variables.tf    # Define variables here
├── outputs.tf      # Define outputs (like ALB DNS, DB endpoint)
├── provider.tf     # AWS provider setup (region, profile)
│
├── vpc.tf          # Create VPC, Subnets, Route Tables, IGW, NAT
├── security_groups.tf  # All Security Groups (Web, App, DB)
├── rds.tf          # Create RDS MySQL database
├── loadbalancer.tf # ALB setup
├── autoscaling.tf  # Launch Templates, AutoScaling groups
│
└── terraform.tfvars # Actual values for your variables (optional)
