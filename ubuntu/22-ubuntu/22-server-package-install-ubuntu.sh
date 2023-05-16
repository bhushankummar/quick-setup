#!/usr/bin/env bash
red=$(tput setaf 1)
reset=$(tput sgr0)
green=$(tput setaf 2)

echo "Thank you, we are installting for the Server"

echo "${green}"
start=$(date +%s)
echo "Start Time ${start}"
echo "${reset}"

echo "${red}"
echo "WARNING : Execute script without sudo command."
echo "${reset}"

# Get Username
CURRENT_USER=$USER
echo "$CURRENT_USER"

# Upgrade to Latest Update
sudo apt-get update -q -y
sudo apt-get upgrade -q -y
sudo apt-get dist-upgrade -q -y

# Install required additional dependencies
sudo apt-get install build-essential -q -y
sudo apt-get install curl -q -y
sudo apt-get install libssl-dev -q -y
sudo apt-get install git -q -y

# Install Docker CE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
sudo apt-get update -q -y
sudo apt-get install docker-ce -q -y

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Set Access for Current User
sudo usermod -a -G docker "$USER"

# Install NVM
curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install Node
export ENV NODE_VERSION=14.19.3
nvm install $NODE_VERSION

# Get SUDO access without password
sudo chmod 0400 /etc/sudoers
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo

# Upgrade to Latest Update
sudo apt-get update -q -y
sudo apt-get upgrade -q -y
sudo apt-get dist-upgrade -q -y

# Remove useless files from the APT cache
sudo apt autoremove -y
sudo apt-get autoclean -y

echo "${green}"
end=$(date +%s)
# echo "End Time ${end}"
seconds=$((end - start))
echo "Installation has been Completed !"
echo "Total Time Taken In Seconds ${seconds}"
eval "echo $(date -ud "@$seconds" +'%H hours %M minutes %S seconds')"
echo "${reset}"
