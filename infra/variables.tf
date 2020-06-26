variable "influxdb_candiate_cpu" {
  type        = number
  description = ""
  default     = 1024
}

variable "influxdb_candidate_memory" {
  type        = number
  description = ""
  default     = 2048
}


variable "aws_region" {
  default = "us-east-1"
}
