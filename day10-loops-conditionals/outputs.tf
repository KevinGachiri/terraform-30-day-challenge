output "upper_names" {
  value = [for name in var.user_names : upper(name)]
}

output "user_arns" {
  value = { 
    for name, user in aws_iam_user.mapped_users :
    name => user.arn 
    }
}