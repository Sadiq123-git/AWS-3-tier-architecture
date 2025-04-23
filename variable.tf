variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}
