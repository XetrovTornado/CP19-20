#!/bin/bash
# Changes all user's passwords that already have a password
# Requires root login
for username in $(grep -v '\:\!\:' /etc/shadow | grep -v '\:\*\:' | cut -d: -f1); do
  if [[ $username != "cyberpatriot" ]]; then
    echo "$username:FortniteMinecraft42!" | chpasswd;
    echo "Changed $username's password";
  fi;
done






