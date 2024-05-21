#!/usr/bin/env bash

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
echo "Start Time: $(date)"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y

# Update and upgrade (combine in one command)
sudo apt update -q -y && sudo apt upgrade -q -y && sudo apt dist-upgrade -q -y

# Install packages (combine in one command)
sudo apt install build-essential curl libssl-dev git -q -y

# Install Docker CE (streamline commands)
sudo apt install docker-ce docker-compose -q -y

# (Optional) Add user to docker group (outside of script for security)
# sudo usermod -a -G docker "$USER"

# Install NVM (use wget for potentially faster download)
curl -L -O https://raw.githubusercontent.com/creationix/nvm/v0.39.7/install.sh | bash

# Load NVM
. ~/.nvm/nvm.sh

# Install Node
nvm install 20.9.0

# Perform system upgrade and cleanup (combine in one command)
sudo apt autoremove -y && sudo apt autoclean -y

# Display completion message and elapsed time
echo "Installation has been Completed!"
display_elapsed_ time