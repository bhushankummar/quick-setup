#!/usr/bin/env bash
red=$(tput setaf 1)
reset=$(tput sgr0)
green=$(tput setaf 2)

echo "Thank you, we are installting for the Desktop"

echo "${green}"
start=$(date +%s)
echo "Start Time ${start}"
echo "${reset}"

echo "${red}"
echo "WARNING : Execute script without sudo command."
echo "${reset}"

# Enable multiverse repository
sudo sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list

# Upgrade to Latest Update
sudo apt-get update -q -y
sudo apt-get upgrade -q -y
sudo apt-get dist-upgrade -q -y

# Install required additional dependencies
sudo apt-get install build-essential -y
sudo apt-get install curl -y
sudo apt-get install libssl-dev -y
sudo apt-get install git -q -y
sudo apt install fuse -y

# Install Python
# sudo apt-get install python-pip python-dev python-virtualenv python-software-properties debconf-utils -y
# sudo apt install software-properties-common apt-transport-https wget -y
# sudo pip install virtualenvwrapper

# Allow Deb File Installation
sudo apt install gdebi -q -y

# -------------------- Desktop Installation Start -------------------- #

# Install Anydesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt update -q -y
sudo apt install anydesk -y
echo hello@world | sudo anydesk --set-password

# Install Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update -q -y
sudo apt-get install google-chrome-stable -y

# Install snapd
sudo apt install snapd -y

# Install Discord
sudo snap install discord -y

# Install Slack
sudo snap install slack

# Install Skype
sudo snap install skype

# Install Postman
sudo snap install postman

# Install Visiul Code
sudo snap install code --classic

# Install Visual Code Extension
sudo code --install-extension monokai.theme-monokai-pro-vscode
sudo code --install-extension christian-kohler.npm-intellisense
sudo code --install-extension christian-kohler.path-intellisense
sudo code --install-extension ms-vscode.vscode-typescript-tslint-plugin
sudo code --install-extension ritwickdey.LiveServer
sudo code --install-extension streetsidesoftware.code-spell-checker
sudo code --install-extension dbaeumer.vscode-eslint
sudo code --install-extension vscode-icons-team.vscode-icons
sudo code --install-extension mikestead.dotenv
sudo code --install-extension codezombiech.gitignore
sudo code --install-extension lacroixdavid1.vscode-format-context-menu
sudo code --install-extension mhutchie.git-graph
sudo code --install-extension tomoki1207.pdf

# Set Visual Code Preference
sudo cp ../.vscode/settings.json $HOME/.config/Code/User/settings.json
sudo cp ../.vscode/keybindings.json $HOME/.config/Code/User/keybindings.json

# Install Wallpaper Changer
sudo add-apt-repository ppa:peterlevi/ppa -y
sudo apt-get update -q -y
sudo apt-get install variety variety-slideshow -y

# Install PrimeTracker
curl -O https://github.com/fullstacktechnologyllp/prime-tracker-app/releases/download/v1.2.0/prime-tracker-desktop_1.2.0_amd64.deb
sudo apt install -y prime-tracker-desktop_1.2.0_amd64.deb

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
