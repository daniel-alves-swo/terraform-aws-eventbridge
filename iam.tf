data "aws_iam_policy_document" "assume_lambda" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "OneVisionDataCleanerRole" {
  name               = "${var.project_name}-one-vision-data-cleaner-role"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda.json
}

resource "aws_iam_role_policy_attachment" "OneVisionDataCleanerPolicy" {
  role       = aws_iam_role.OneVisionDataCleanerRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "OneVisionDataCollectorRole" {
  name               = "${var.project_name}-one-vision-data-collector-role"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda.json
}

resource "aws_iam_role_policy_attachment" "OneVisionDataCollectorPolicy" {
  role       = aws_iam_role.OneVisionDataCollectorRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
