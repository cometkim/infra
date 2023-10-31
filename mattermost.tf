resource "aws_lightsail_instance" "mattermost_instance" {
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

resource "cloudflare_r2_bucket" "mattermost_bucket" {
  account_id = data.cloudflare_accounts.me.id
  name       = "mattermost"
}
