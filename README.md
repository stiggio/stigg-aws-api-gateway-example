# Stigg backend integration example - API Gateway

<img src="docs/StiggIcon.svg" width="50" alt="Stigg Logo">
<img src="docs/AWS-API-Gateway.svg" width="50" alt="API Gateway">

This repository contains an example for integration with Stigg using AWS API Gateway (HTTP).

Read the full article at Stigg [documentation](https://docs.stigg.io/docs/api-gateway).

## About authorizer lambda structure

* Entrypoint at [index.js](authorizer/index.js)
* Route definitions at [routes.js](authorizer/routes.js)
* Stigg's feature definitions at [features.js](authorizer/features.js)
* Business logic to determine access at [checkRouteEntitlements.js](authorizer/checkRouteEntitlements.js)

## Deployment

This project can be easily deployed using terraform after cloning the repository.

### Requirements

* AWS CLI configured
* Terraform installed
* You'll need a Stigg account in order to get Server API key and run this project.

### Setup

* Clone the repository:
  ```
  git clone git@github.com:stiggio/stigg-aws-api-gateway-example.git
  ```
* Install the `@stigg/node-server-sdk` dependency using yarn:
  ```
  cd node-server-sdk-layer/nodejs/
  yarn
  ```
* Obtain Server API key from https://app.stigg.io/account/settings
* Create `terraform/.tfvars` file with variables values:
  ```
  owner = "<YOUR_NAME>"
  stigg_server_api_key = "<STIGG_SERVER_API_KEY>"
  ```
* Deploy application:
  ```
  cd terraform
  terraform init
  terraform apply -var-file=.tfvars
  ```
* Extract the API Gateway host from the output of the above command.

### Running REST calls

The below is example of available REST request:
```http request
POST {{api-gateway-url}}/api/collaborators/
Authorization: Bearer {{customerId}}
```
The following placeholders should be replaced:
* `{{api-gateway-ur}}` should be replaced with the API Gateway url (extracted at the `Setup` section)
* `{{customerId}}` should be replaced with an ID of a Stigg customer.


> See a full description of available REST calls at [requests.http](./requests.http)
