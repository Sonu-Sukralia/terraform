# Terraform Commands Cheat Sheet

A quick reference for the Terraform commands used in this project.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) installed (`terraform -version`)
- [AWS CLI](https://aws.amazon.com/cli/) installed and configured (`aws configure`)
- AWS credentials with permission to create the resources in the `.tf` files

## Quick Start

```bash
terraform init       # download providers and modules
terraform validate   # check the code
terraform plan       # preview the changes
terraform apply      # create the resources (type yes)
terraform destroy    # delete everything when finished
```

Typical workflow:

```
write code -> fmt -> init -> validate -> plan -> apply -> ... -> destroy
```

## Main Workflow Commands

| Command | Description | Changes AWS? |
|---|---|---|
| `terraform init` | Downloads providers and modules, prepares the folder | No |
| `terraform fmt` | Formats code neatly | No |
| `terraform validate` | Checks syntax and configuration | No |
| `terraform plan` | Previews what will be created, changed or deleted | No |
| `terraform apply` | Creates or updates resources (asks for `yes`) | **Yes** |
| `terraform destroy` | Deletes all resources Terraform created (asks for `yes`) | **Yes** |

## Inspecting Resources

| Command | Description |
|---|---|
| `terraform show` | Prints the current state in readable form |
| `terraform output` | Prints all output values |
| `terraform output <name>` | Prints one output value, e.g. `bucket_name` |
| `terraform state list` | Lists all resources Terraform tracks |
| `terraform state show <resource>` | Shows details of one resource |
| `terraform providers` | Lists the providers used |
| `terraform version` | Shows Terraform and provider versions |
| `terraform graph` | Prints a resource dependency graph |

## Managing State

| Command | Description |
|---|---|
| `terraform state rm <resource>` | Stops tracking a resource (does not delete it in AWS) |
| `terraform state mv <old> <new>` | Renames or moves a resource in the state |
| `terraform import <resource> <id>` | Brings an existing AWS resource under Terraform |
| `terraform refresh` | Syncs state with real AWS (done automatically by `plan`) |
| `terraform force-unlock <ID>` | Removes a stuck state lock |

## Replacing or Targeting Resources

| Command | Description |
|---|---|
| `terraform apply -replace=<resource>` | Destroys and recreates one resource |
| `terraform apply -target=<resource>` | Applies changes to one resource only |
| `terraform destroy -target=<resource>` | Destroys one resource only |
| `terraform taint <resource>` | Marks a resource for recreation (older method) |
| `terraform untaint <resource>` | Removes the taint mark |

## Useful Options

| Option | Description |
|---|---|
| `-var="name=value"` | Sets a variable from the command line |
| `-var-file="dev.tfvars"` | Loads variables from a file |
| `-auto-approve` | Skips the `yes` prompt (use carefully) |
| `plan -out=tfplan` | Saves the plan to a file |
| `apply tfplan` | Applies exactly the saved plan |
| `init -upgrade` | Updates providers to the newest allowed versions |
| `init -reconfigure` | Reconfigures the backend |
| `fmt -recursive` | Formats files in subfolders too |
| `plan -destroy` | Previews what a destroy would do |

## Other Commands

| Command | Description |
|---|---|
| `terraform console` | Interactive prompt to test expressions |
| `terraform workspace list` | Lists workspaces |
| `terraform workspace new <name>` | Creates a separate state (e.g. dev, prod) |
| `terraform workspace select <name>` | Switches workspace |
| `terraform login` | Logs in to Terraform Cloud |
| `terraform test` | Runs Terraform test files |

## Files Terraform Creates

| File / Folder | Purpose | Commit to Git? |
|---|---|---|
| `*.tf` | Your Terraform code | Yes |
| `.terraform.lock.hcl` | Locks provider versions | Yes |
| `.terraform/` | Downloaded providers and modules | No |
| `terraform.tfstate` | Record of what exists in AWS | No |
| `terraform.tfstate.backup` | Previous state copy | No |
| `*.tfvars` | Variable values (may contain secrets) | No |

## Recommended `.gitignore`

```gitignore
.terraform/
*.tfstate
*.tfstate.*
crash.log
*.tfvars
*Zone.Identifier
```

## Notes

- Always read the `terraform plan` output before running `apply`.
- Run `terraform destroy` when you are done testing to avoid unexpected AWS charges.
- Never commit state files or AWS access keys to Git.