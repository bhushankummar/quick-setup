#!/bin/bash

is_installed() {
  program_name="$1"

  # Check if the program's desktop file exists in the standard location
  if [ ! -f "/usr/share/applications/$program_name.desktop" ]; then
    echo "$program_name is not installed or doesn't have a desktop file."
    return 1
  fi

  return 0  # Program is considered installed
}

# Function to add an app to favorites
add_to_favorites() {
  desktop_file="$1"

  # Check if desktop file exists
  if [ ! -f "$desktop_file" ]; then
    echo "Error: '$desktop_file' not found. Skipping."
    return 1
  fi

  # Call the is_installed function to check program availability
  if ! is_installed "$(basename "$desktop_file" .desktop)"; then
    echo "$(basename "$desktop_file" .desktop) is not installed. Skipping."
    return 1
  fi

  # Escape special characters
  escaped_desktop_file=$(echo "$desktop_file" | sed 's/\\//\\\\/')

  # Check if app is already in favorites
  current_favorites=$(gsettings get org.gnome.shell favorite-apps)
  if grep -q "'$escaped_desktop_file'" <<< "$current_favorites"; then
    echo "$desktop_file already exists in your favorites."
    return 0
  fi

  # Construct the new favorites list
  new_favorites="$current_favorites, '$escaped_desktop_file'"

  # Update the favorites list using gsettings
  gsettings set org.gnome.shell favorite-apps "$new_favorites"

  if [ $? -eq 0 ]; then
    echo "$desktop_file added to your favorites successfully."
  else
    echo "Error: Failed to update favorites list for $desktop_file."
  fi
}

fix_anydesk(){
	## AnyDesk - fix the "display server not supported" error
	# Edit the GDM3 configuration file with nano and set Wayland disabled
	sudo nano /etc/gdm3/custom.conf

	# Search for the "[daemon]" section (case-sensitive)
	grep -q '^\[daemon\]' /etc/gdm3/custom.conf

	# If the section is found (exit code 0), uncomment WaylandEnable=false
	if [ $? -eq 0 ]; then
	sed -i 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
	echo "Wayland disabled in /etc/gdm3/custom.conf"
	else
	echo "WARNING: [daemon] section not found in /etc/gdm3/custom.conf"
	echo "Wayland settings might not be present or the file structure might be different."
	fi
}