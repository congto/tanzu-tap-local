#!/bin/bash -e

# Cleanup
sudo apt-get remove docker docker-engine docker.io containerd runc
# Install Packages
sudo apt-get update -y 
sudo apt-get install ca-certificates curl gnupg lsb-release vim byobu git jq -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y
# Post install permissions
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker

# copy the config file to where carvel tools expect it
mkdir ~/.docker
# cp /var/snap/docker/current/config/daemon.json ~/.docker/config.json # if you find issue with kube proxy starting up, may need to run this command.  Found it just recently - UPDATE only seemed needed in the snap versions of docker
sudo sysctl net/netfilter/nf_conntrack_max=131072

ssh-keygen -t rsa -b 4096 -N "" -f $HOME/.ssh/id_rsa

echo "Khoi dong lai OS"
sleep 3
# sudo reboot now

# Install pivnet - https://github.com/pivotal-cf/pivnet-cli
curl -LO https://github.com/pivotal-cf/pivnet-cli/releases/download/v3.0.1/pivnet-linux-amd64-3.0.1
chmod +x ./pivnet-linux-amd64-3.0.1
sudo mv pivnet-linux-amd64-3.0.1 /usr/local/bin/pivnet
# Get your Pivnet API Token at the bottom of the [Pivnet Profile Page](https://network.pivotal.io/users/dashboard/edit-profile).  
pivnet login --api-token 3edc72122e594eb2a72fccd6d0de75bb-r

# Install jq - https://stedolan.github.io/jq/
sudo apt-get install jq -y

# Install HTTPie
sudo apt install httpie -y


curl -LO https://dl.k8s.io/release/v1.21.12/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Helpful Alias
echo "alias k=kubectl" >> ~/.bashrc
source ~/.bashrc

# Install kubectx/kubens
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# Install fzf (for fuzy finder kubectx)
sudo apt-get update -y
sudo apt-get install fzf -y


# Install kubie
sudo wget https://github.com/sbstp/kubie/releases/download/v0.19.1/kubie-linux-amd64 -O /usr/bin/kubie
sudo chmod +x /usr/bin/kubie


# Install yq - per https://github.com/mikefarah/yq
sudo wget https://github.com/mikefarah/yq/releases/download/v4.21.1/yq_linux_amd64 -O /usr/bin/yq
sudo chmod +x /usr/bin/yq


