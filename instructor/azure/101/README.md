# HashiCorp Azure Training Instructor Setup
This repo is for setting up the user accounts for each student.

## Process
### Generate List of Usernames
1. Gather a list of email addresses for all Workshop attendees and format like so:
```
email_list = ["test@hashicorp.com","example@hashicorp.com"]
```
2. Use the python script in the [setup_scripts](./setup_scripts/strip_emails) directory to generate a list of usernames
3. Set the resulting list as the 'users' value in the terraform.tfvars file in the [terraform](./terraform) directory before running `terraform apply`

### Create Student Accounts
1. Unset any Azure Credential Environment Variables in your terminal (ex. `unset ARM_X`)
2. Navigate to the [terraform](./terraform) directory and authenticate to your training account by running `az login` and selecting your `@hashicorptraining.onmicrosoft.com` account.
3. Update the terraform.tfvars file by adding a list of attendees in the following format:
```
users = ["student1", "student2", ...]
```
4. Run `terraform plan` and `terraform apply`
5. Distribute usernames and passwords to students to use (gists are easiest)

### Enable Enterprise Features for all Student TFC Orgs
1. Gather the names of all TFC Orgs that students have created (a shared Google Sheet is easiest)
2. Paste the list (one Org name per line) in the 'orgs_to_update.txt' file in the [tfc_enable_features](./setup_scripts/tfc_enable_features) directory and save
3. Execute the update_permissions.sh script in the [tfc_enable_features](./setup_scripts/tfc_enable_features)  directory like so:
```
./update_permissions.sh < orgs_to_update.txt
```
**Note:** You need to set the `TOKEN` environment variable in your terminal beforehand, and this token must be a User Token with Admin permissions
