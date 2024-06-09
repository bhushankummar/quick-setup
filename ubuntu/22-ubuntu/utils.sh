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
  app_name="$1"

  # Search for the desktop file associated with the application
  desktop_file=$(locate -r "\/$app_name\.desktop$" | head -n 1)

  # Check if desktop file exists
  if [ -z "$desktop_file" ]; then
    echo "Error: Desktop file for '$app_name' not found. Skipping." >&2
    return 1
  fi

  # Call the is_installed function to check program availability
  if ! is_installed "$app_name"; then
    echo "$app_name is not installed. Skipping." >&2
    return 1
  fi

  # Escape special characters
  escaped_desktop_file=$(echo "$desktop_file" | sed 's/\\//\\\\/')

  # Check if app is already in favorites
  current_favorites=$(gsettings get org.gnome.shell favorite-apps)
  if grep -q "'$escaped_desktop_file'" <<< "$current_favorites"; then
    echo "$app_name is already in your favorites."
    return 0
  fi

  # Construct the new favorites list
  new_favorites="$current_favorites, '$escaped_desktop_file'"

  # Update the favorites list using gsettings
  if ! gsettings set org.gnome.shell favorite-apps "$new_favorites"; then
    echo "Error: Failed to update favorites list for $app_name." >&2
    return 1
  else
    echo "$app_name added to your favorites successfully."
    return 0
  fi
}

fix_anydesk() {
    # Check if the [daemon] section exists
    if grep -q '^\[daemon\]' /etc/gdm3/custom.conf; then
        # Disable Wayland if enabled
        sudo sed -i 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
        echo "Wayland disabled in /etc/gdm3/custom.conf"
    else
        echo "WARNING: [daemon] section not found in /etc/gdm3/custom.conf"
        echo "Wayland settings might not be present or the file structure might be different."
    fi
}