#!/usr/bin/env bash
source ./utils.sh

# Set colors for terminal output
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
	echo "======================== Total Time Taken: $elapsed_time ======================== "
}

# Display installation start message
echo "********************************* Thank you, we are installing for the Desktop. *********************************"
echo "${green}Start Time: $(date)${reset}"

# Warning message
echo "${red}WARNING: Execute script without sudo command.${reset}"

# Make sure the function script is executable (if needed)
chmod +x utils.sh

# Enable multiverse repository
sudo sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list

# Install Anydesk
curl -sL https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list

# Install Wallpaper Changer
sudo add-apt-repository ppa:peterlevi/ppa -y

# Install Google Chrome
curl -sL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

# Update and upgrade (combine in one command)
sudo apt update -q -y && sudo apt upgrade -q -y && sudo apt dist-upgrade -q -y

# Install required packages
sudo apt-get install libssl-dev git fuse gdebi snapd anydesk variety variety-slideshow google-chrome-stable -q -y
fix_anydesk

# Install Snap Packages
sudo snap install code --classic
sudo snap install discord
sudo snap install slack
sudo snap install skype
sudo snap install postman

# Install Visual Studio Code extensions
sudo code --user-data-dir="~/.config/Code" --install-extension monokai.theme-monokai-pro-vscode
sudo code --user-data-dir="~/.config/Code" --install-extension christian-kohler.npm-intellisense
sudo code --user-data-dir="~/.config/Code" --install-extension christian-kohler.path-intellisense
sudo code --user-data-dir="~/.config/Code" --install-extension ms-vscode.vscode-typescript-tslint-plugin
sudo code --user-data-dir="~/.config/Code" --install-extension ritwickdey.LiveServer
sudo code --user-data-dir="~/.config/Code" --install-extension streetsidesoftware.code-spell-checker
sudo code --user-data-dir="~/.config/Code" --install-extension dbaeumer.vscode-eslint
sudo code --user-data-dir="~/.config/Code" --install-extension vscode-icons-team.vscode-icons
sudo code --user-data-dir="~/.config/Code" --install-extension mikestead.dotenv
sudo code --user-data-dir="~/.config/Code" --install-extension codezombiech.gitignore
sudo code --user-data-dir="~/.config/Code" --install-extension lacroixdavid1.vscode-format-context-menu
sudo code --user-data-dir="~/.config/Code" --install-extension mhutchie.git-graph
sudo code --user-data-dir="~/.config/Code" --install-extension tomoki1207.pdf

# Install PrimeTracker
curl -L -O https://github.com/fullstacktechnologyllp/prime-tracker-app/releases/latest/download/prime-tracker-linux-amd64.deb
sudo gdebi -n ./prime-tracker-linux-amd64.deb

# Add App into Favourite
add_to_favorites "prime-tracker-desktop.desktop"
add_to_favorites "discord_discord.desktop"
add_to_favorites "code_code.desktop"
add_to_favorites "anydesk.desktop"
add_to_favorites "google-chrome.desktop"

# Cleanup
sudo apt autoremove -y
sudo apt-get autoclean -y

# Display completion message and elapsed time
echo "${green}Installation has been Completed!"
display_elapsed_time
echo "${reset}"
