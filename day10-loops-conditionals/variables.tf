variable "user_names" {
    type = list(string)
    default = ["alice", "bob", "charlie"]
}

variable "environment"{
    type = string
    default = "dev"
}

variable "enable_autoscaling" {
    type = bool
    default = false
}

variable "subnet_ids" {
    type = list(string)
}

variable "launch_template_id" {
    type = string
}