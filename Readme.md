In Terraform v0.13 and earlier, the terraform init command would always install the newest version of any provider in the configuration that would meet the configured version constraints.

That meant that unless the configuration author manually entered exact version constraints (for a particular version alone), a later provider release could potentially cause a change in behavior for an existing configuration even though the configuration itself had not changed.

We believe that, as far as possible, the behavior of a configuration that has already been written and tested should remain consistent unless it is intentionally changed by its author, and that intentional changes should be represented in files that can be included in a version control system and code review process.

To better meet that goal, Terraform v0.14 introduces a new dependency lock file[https://www.terraform.io/docs/language/dependency-lock.html], which Terraform will generate automatically after running terraform init in the same directory as your configuration's root module. This file includes the specific version numbers selected for each provider, and also includes the package checksums for the selected version to help ensure that the provider packages you depend on are not changed in-place upstream, whether accidentally or maliciously.

This new behavior is designed so that for most users it will not require a significant change in workflow. After running terraform init for the first time after upgrading you will find a new file .terraform.lock.hcl in your root module directory, and terraform init will automatically read and respect the entries in that file on future runs with no additional action on your part.