# Define IAM Policy
data "aws_iam_policy_document" "web_server_restart_policy" {
  statement {
    actions = [
      "ec2:RebootInstances",
      "ec2:StopInstances",
      "ec2:StartInstances",
    ]
    resources = [
      for asg_name in aws_autoscaling_group.webserver_asg.name : "arn:aws:ec2:*:*:instance/*"
    ]
  }
}

# Define IAM Policy Attachment
resource "aws_iam_policy" "web_server_restart_policy" {
  name        = "web_server_restart_policy"
  policy      = data.aws_iam_policy_document.web_server_restart_policy.json
}

# Define IAM User
resource "aws_iam_user" "web_user" {
  name = var.iam_user_name
}

# Attach IAM Policy to IAM User
resource "aws_iam_user_policy_attachment" "web_user_policy_attachment" {
  user       = aws_iam_user.web_user.name
  policy_arn = aws_iam_policy.web_server_restart_policy.arn
}

