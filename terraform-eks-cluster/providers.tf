# Place provider configurations in this file.
# Leverage environment variables where possible
# If you are using them for auth then specify it with a comment in the provider block
# providers.tf shouldn't be present in module definitions. They should generally inherit the root module provider provider unless you need to do aliasing.

/* provider "aws" {
  # using environment variables
} */

# e.g: You can configure your environment to supply the region:
# export AWS_REGION=ap-southeast-1


/* Terraform automatically detects the AWS_REGION environment variable and uses it for the provider’s region value. 
This keeps your code clean and makes it easy to switch regions without changing your configuration files — 
just update the environment variable value. 
This method also applies to other AWS configuration parameters supported by environment variables.
*/