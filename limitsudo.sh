#!/bin/bash

echo "Adding wanted sudoers…"
for add_sudo in $@; do
    gpasswd -a $add_sudo sudo && echo "Added $add_sudo to sudo group"
done;

echo "Removing unwanted sudoers…"
for sudo_user in $(grep "^sudo:" /etc/group | cut -d: -f4 | tr ',' ' '); do
    keep_current_user=0
    for keep_user in $@; do
        if [[ $sudo_user == $keep_user ]]; then
            keep_current_user=1
            break
        fi
    done
    if [[ $keep_current_user == 0 ]]; then
        gpasswd -d $sudo_user sudo && echo "Removed $sudo_user from sudo group"
    fi
done


    


