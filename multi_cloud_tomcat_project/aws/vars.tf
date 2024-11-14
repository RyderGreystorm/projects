variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AWS_ZONES" {
    type = map(string)
    default = {
        zone1 = "us-east-1a"
        zone2 = "us-east-1b"
        zone3 = "us-east-1c"

    }
}

variable "AWS_AMIS" {
    type = map(string)
    default = {
        ubuntu = "ami-011079f19d63f2405"
        amz_linix = "ami-063d43db0594b521b"
        centOS = "ami-0df2a11dd1fe1f8e3"

    }
}

variable "USER" {
  default = "ubuntu"
}

variable "PUB_KEY" {
  default = "multikey.pub"
}

variable "PRIV_KEY" {
  default = "multikey"
}

