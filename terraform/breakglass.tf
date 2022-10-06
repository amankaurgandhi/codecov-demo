// Cloudwatch Alarm for breakglass user

resource "aws_cloudwatch_event_rule" "console" {
  name        = "capture-aws-breakglass-user-sign-in"
  description = "Capture each AWS Console Sign In"

  event_pattern = <<EOF
{
  "detail-type": ["AWS Console Sign In via CloudTrail"],
  "source": ["aws.signin"],
  "detail": {
    "eventName": ["ConsoleLogin"],
    "userIdentity": {
      "type": ["IAMUser"],
      "userName": ["amanaws-user-breakglass"]
    }
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.console.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.aws_logins.arn
}

resource "aws_sns_topic" "aws_logins" {
  name = "aws-console-logins"
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.aws_logins.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.aws_logins.arn]
  }
}

// Cloudwatch Alarm for breakglass user switch role

resource "aws_cloudwatch_event_rule" "sr" {
  name        = "capture-breakglass-user-switch-role"
  description = "Capture breakglass user switching roles"

  event_pattern = <<EOF
{
  "source": ["aws.signin"],
  "detail-type": ["AWS Console Sign In via CloudTrail"],
  "detail": {
    "eventSource": ["signin.amazonaws.com"],
    "eventName": ["SwitchRole"],
    "userIdentity": {
      "type": ["IAMUser"],
      "userName": ["amanaws-user-breakglass"]
    }
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "sns-sr" {
  rule      = aws_cloudwatch_event_rule.sr.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.aws_logins.arn
}
