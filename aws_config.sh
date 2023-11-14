HCP_API_TOKEN=$(curl --location 'https://auth.hashicorp.com/oauth/token' \
--header 'content-type: application/json' \
--data '{
"audience": "https://api.hashicorp.cloud",
"grant_type": "client_credentials",
"client_id": "'$HCP_CLIENT_ID'",
"client_secret": "'$HCP_CLIENT_SECRET'"
}' | jq -r .access_token)

AWS_CLI_ACCESS_KEY=$(curl \
--location "https://api.cloud.hashicorp.com/secrets/2023-06-13/organizations/bcbbbeef-63c1-4d68-bd46-9403306848dc/projects/5504c933-8156-429a-85c2-0ec1443dc5d8/apps/AWS-Lightsail-Demo/open/LS_CLI_Access_Key" \
--request GET \
--header "Authorization: Bearer $HCP_API_TOKEN" | jq -r .secret.version.value)

AWS_SECRET_ACCESS_KEY=$(curl \
--location "https://api.cloud.hashicorp.com/secrets/2023-06-13/organizations/bcbbbeef-63c1-4d68-bd46-9403306848dc/projects/5504c933-8156-429a-85c2-0ec1443dc5d8/apps/AWS-Lightsail-Demo/open/LS_Secret_Access_Key" \
--request GET \
--header "Authorization: Bearer $HCP_API_TOKEN" | jq -r .secret.version.value)

echo $AWS_CLI_ACCESS_KEY
echo $AWS_SECRET_ACCESS_KEY

aws configure set aws_access_key_id $AWS_CLI_ACCESS_KEY --profile ps-ls-user
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY --profile ps-ls-user
aws configure set region "eu-north-1a" --profile ps-ls-user
aws configure set output "json" --profile ps-ls-user
aws configure list --profile ps-ls-user