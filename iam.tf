resource "aws_iam_instance_profile" "elasticsearchrole" {
  name = "elasticsearchrole"
  role = "${aws_iam_role.elasticsearchrole.name}"
}
resource "aws_iam_role" "elasticsearchrole" {
  name = "test-role"


  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            }
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy" "role_policy" {
  role = "${aws_iam_role.elasticsearchrole.id}"
  name = "elasticsearch-role-policy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "s3:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
          "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "ec2-ssm-role" {
  role = "${aws_iam_role.elasticsearchrole.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

