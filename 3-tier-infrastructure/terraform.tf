terraform {
    backend "s3" {
        bucket = "3-tier-state-file-bucket"
        key    = "terraform.tfstate"
        region = "eu-west-1"
        use_lockfile = true
    }
}