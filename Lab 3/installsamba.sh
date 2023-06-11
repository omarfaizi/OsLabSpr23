#!/bin/bash

# Prompt for user input
read -p "Enter the username for SAMBA: " username
read -s -p "Enter the password for SAMBA: " password
echo

# Install SAMBA server
echo "Installing SAMBA server..."
sudo apt-get update
sudo apt-get install -y samba

# Configure SAMBA
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.backup
sudo bash -c "cat > /etc/samba/smb.conf << EOL
[global]
   workgroup = WORKGROUP
   server string = Samba Server %v
   netbios name = ubuntu
   security = user
   map to guest = bad user
   name resolve order = bcast host
   dns proxy = no
   bind interfaces only = yes

[shared]
   path = /home/$USER/shared
   writable = yes
   guest ok = yes
   guest only = yes
   create mask = 0777
   directory mask = 0777
   force user = $username
   force group = $username
EOL"

# Create a shared folder
mkdir -p "/home/$USER/shared"
sudo chown -R $USER:$USER "/home/$USER/shared"

# Add SAMBA user
echo -e "$password\n$password" | sudo smbpasswd -a $username

# Restart SAMBA service
sudo systemctl restart smbd

echo "SAMBA server installed and configured successfully."

