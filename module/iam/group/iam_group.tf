resource "aws_iam_group" "iam-group" {
	name = "${var.aws_iam_groupname}"
	path = "${var.aws_iam_grouppath}"
}