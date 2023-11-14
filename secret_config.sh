printf "\nEnter Hashicorp Client ID: "
read HCP_CLIENT_ID
printf "\nEnter Hashicorp Client secret: "
read HCP_CLIENT_SECRET
export HCP_CLIENT_ID
export HCP_CLIENT_SECRET
sudo yum install jq -y