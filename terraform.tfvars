region = "eu-central-1"
shared_credentials_file = "~/.aws/credentials"

# cat ~/.aws/credentials | head -1 | sed -e 's/\[//g' | sed -e 's/\]//g'
profile = "terraform"

webp_ami = "ami-c7e0c82c"
webp_instance_type = "t2.micro"

key_name = "terraform"
count = 2
