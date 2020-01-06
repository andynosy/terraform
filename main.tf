provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

# ====================== I AM ================================
#S3 access
resource "aws_iam_instance_profile" "s3_access_profile" {
  name = "s3_access"
  role = "${aws_iam_role.s3_access_role.name}"

}

resource "aws_iam_role_policy" "s3_acess_policy" {
  name = "s3_access_policy"
  role = "${aws_iam_role.s3_access_role.id}"

  policy = <<EOF
{
  "version": "2020-01-05",
  "statement": [
   {
       "Effect": "Allow",
       "Action": "s3:*",
       "Resource": "*"
}
   ]

}

EOF

}


resource "aws_iam_role" "s3_access_role" {
  name = "s3_access_role"
  assume_role_policy = <<EOF
{
  "Version": "2020-01-50",
  "statement": [
    {
      "Action": "sts:AssumerRole",
      "Principle": { 
         "service": "ec2.amazoneaws.com"
  },
      "Effect": "Allow",
      "Sid": ""
      }

]
}
EOF
}
