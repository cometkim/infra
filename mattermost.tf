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

resource "neon_project" "mattermost" {
  name = "mattermost"
}

resource "neon_branch" "mattermost_main" {
  project_id = neon_project.mattermost.id
  name       = "main"
}

resource "neon_role" "mattermost_admin" {
  project_id = neon_project.mattermost.id
  branch_id  = neon_branch.mattermost_main.id
  name       = "admin"
}

resource "neon_database" "mattermost_db" {
  project_id = neon_project.mattermost.id
  branch_id  = neon_branch.mattermost_main.id
  owner_name = neon_role.mattermost_admin.name
  name       = "mattermost"
}
