resource "aws_lightsail_instance" "mattermost" {
  name              = "mattermost"
  availability_zone = "${var.aws_region}a"
  blueprint_id      = "amazon_linux_2023"
  bundle_id         = "small_3_0"
  add_on {
    type          = "AutoSnapshot"
    snapshot_time = "06:00"
    status        = "Enabled"
  }

  tags = {
    product = "mattermost"
  }
}
