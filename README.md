# sawdustshop-overhaul
More manageable implementation of the saw dust shop allowing for the user to manage their own content

## Infrastructure

Terraform lives in `infra/`. Its state is stored in the S3 bucket `sawdustshop-tf-bucket` (us-east-1), with S3-native state locking (`use_lockfile`).

### Bootstrap (`infra/bootstrap/`)

The state bucket can't store the state of the config that creates it, so `infra/bootstrap/` is a separate, run-once config that creates the bucket (versioning, AES256 encryption, public access blocked, 60-day noncurrent-version expiry, `prevent_destroy`).

Design choice: bootstrap uses **local state**, which is gitignored and never committed. It is meant to be applied once and left alone, so it is not migrated into the bucket it created. If the local state is ever lost, the bucket is unaffected; the fix is to `terraform import` the bootstrap resources rather than re-apply.
