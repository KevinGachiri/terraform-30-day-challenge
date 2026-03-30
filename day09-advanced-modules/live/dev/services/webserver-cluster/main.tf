module "webserver_cluster" {
    source = "github.com/KevinGachiri/terraform-30-day-challenge/day09-advanced-modules/modules/webserver-cluster"

    cluster_name = "webservers-dev"
    instance_type = "t2.micro"
    min_size = 2
    max_size = 4
}