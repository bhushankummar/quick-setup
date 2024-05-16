#!/usr/bin/env bash

# Define colors for terminal output
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

# Start timer
start=$(date +%s)

# Function to display elapsed time
display_elapsed_time() {
    end=$(date +%s)
    seconds=$((end - start))
    elapsed_time=$(date -ud "@$seconds" +'%H hours %M minutes %S seconds')
    echo "Total Time Taken: $elapsed_time"
}

# Display installation start message
echo "Thank you, we are installing for the Server"
echo "${green}Start Time: $(date)${reset}"

# Warning message
echo "${red}WARNING: Execute script without sudo command.${reset}"

# Update repository and upgrade system
sudo apt-get update -q -y
sudo apt-get upgrade -q -y
sudo apt-get dist-upgrade -q -y

# Install required packages
sudo apt-get install build-essential curl libssl-dev git -q -y

# Install Docker CE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
sudo apt-get update -q -y
sudo apt-get install docker-ce -q -y

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Add current user to docker group
sudo usermod -a -G docker "$USER"

# Install NVM
curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.7/install.sh | bash

# Load NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node
nvm install 20.9.0

# Grant sudo access without password
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo

# Perform system upgrade and cleanup
sudo apt-get update -q -y
sudo apt-get upgrade -q -y
sudo apt-get dist-upgrade -q -y
sudo apt autoremove -y
sudo apt-get autoclean -y

# Display completion message and elapsed time
echo "${green}Installation has been Completed!"
display_elapsed_time
echo "${reset}"