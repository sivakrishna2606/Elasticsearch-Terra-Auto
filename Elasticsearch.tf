resource "aws_instance" "elasticsearch_instance" {
  ami           = "ami-0927ed83617754711"
  instance_type = "${var.aws_instance_type}"
  security_groups = ["${aws_security_group.elasticsearch_cluster_sg.name}"]
  iam_instance_profile = "${aws_iam_instance_profile.elasticsearchrole.name}"
  #user_data = "${file("elasticsearch-node-setup.sh")}"
  count = "1"

  tags = {
    Environment = "elk"
  }
}