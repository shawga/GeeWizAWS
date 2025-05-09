module "security_baseline" {
  source = "../modules/security-baseline"
  enable_guardduty = true
  enable_cloudtrail = true
  log_bucket = module.vpc.vpc_id == "" ? "global-log-bucket" : local.log_bucket_name
}
resource "aws_cloudtrail" "trail" {
  name                          = "org-trail"
  s3_bucket_name                = var.log_bucket_name
  is_multi_region_trail         = true
  enable_log_file_validation    = true
}
resource "aws_guardduty_detector" "detector" { enable = true }