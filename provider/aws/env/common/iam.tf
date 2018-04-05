module "iam-group" {
	source = "../../../../module/iam/group/"
	aws_iam_groupname = "oreore"
	aws_iam_grouppath = "/oreore/"
}

module "iam-user" {
	source = "../../../../module/iam/user/"
	aws_iam_username = "oreore"
	aws_iam_grouppath = "/oreore/users/"
}

