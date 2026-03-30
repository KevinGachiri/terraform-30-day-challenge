module "webserver_cluster" {
    source = "github.com/KevinGachiri/terraform-30-day-challenge//day09-advanced-modules/modules/webserver-cluster?ref=v0.0.1"

    cluster_name = "webservers-prod"
    instance_type = "t2.micro"
    min_size = 2
    max_size = 4
}