github actions ci - vault - terraform - aws

eks-install/backend/main.tf successful at first time following https://github.com/Roopa-Jagulur/DevSecOps-Zero-to-Hero/blob/main/03-IaC/02-Vault.md just changing configurations according to project.

eks-install/main.tf which creates vpc and eks cluster resources on AWS was unsccessfull 
Reporting 
Initializing the backend...
╷
╷
│ Error: validating provider credentials: retrieving caller identity from STS: operation error STS: GetCallerIdentity, https response error StatusCode: 403, RequestID: cef7ac2f-cbe6-46c4-bf4d-1596b067b6b4, api error InvalidClientTokenId: The security token included in the request is invalid.
│ Warning: Deprecated Parameter
│ 
│ 
│ 
│   on main.tf line 15, in terraform:
│   15:     dynamodb_table = "dso-terraform-eks-state-locks"
╵
│ 
│ The parameter "dynamodb_table" is

hence I decided to remove anything that eks-install/main.tf refering to eks-install/backend/* then pipeline has succesful as I would like to see just Terraform init and plan becoming success.

So what I understood with debugging, anything that related to eks-install/backend/main.tf need to run saperately from eks-install/main.tf (which is for els and vpc)

