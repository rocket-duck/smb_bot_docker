# smb_bot_docker

git clone git@github.com:rocket-duck/smb_bot_docker.git
cd smb_bot_docker/
cp ~/.ssh/id_rsa ~/.ssh/id_rsa.pub .
docker build -t smb_bot .
docker run -d --name smb_bot smb_bot
