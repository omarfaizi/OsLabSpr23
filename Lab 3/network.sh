#!/bin/bash

# Get network information
network_info=$(ifconfig)

# Email configuration
recipient="Recipient : "
subject="Subject : "
body="Body : \n\n$network_info"

# Send email
echo -e "$body" | mail -s "$subject" "$recipient"

echo "Network information sent to email."

