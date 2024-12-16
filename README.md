# smb_bot_docker

### Clone repo
git clone git@github.com:rocket-duck/smb_bot_docker.git

cd smb_bot_docker/

### Clone ssh key
cp ~/.ssh/id_rsa ~/.ssh/id_rsa.pub .

### Build docker
docker build -t smb_bot .


### Start docker
docker run -d --name smb_bot smb_bot
