# CyberPatriots19-20
Scripts for McK. HS CP19-20

# Forensic Questions

Find files

```bash
sudo updatedb
locate "**/*.mp3"
```

Check groups

```bash
# Option 1:
getent group groupname
# Option 2:
cat /etc/groups | grep "groupname"
```

Check users
```bash
sudo cut -d: -f1 /etc/passwd | grep -v -E '(root|daemon|bin|sys|sync|games|man|lp|mail|news|uucp|proxy|www-data|backup|list|irc|gnats|nobody|libuuid|syslog|messagebus|colord|lightdm|whoopsie|avahi-autoipd|avahi|usbmux|kernoops|pulse|rtkit|speech-dispatcher|dispatcher|hplip|saned|ubuntu)'
```

Find programs
```bash
for app in /usr/share/applications/*.desktop ~/.local/share/applications/*.desktop; do app="${app##/*/}"; echo "${app::-8}"; done
```

# Lockdown Checklist

### GUI

* Enable automatic updates
* Update Firefox 🔥🦊 and disable pop ups

### Terminal

limitusers.sh

```bash
```

limitsudo.sh

```bash
echo '

echo "Adding wanted sudoers…"
for add_sudo in $@; do
    gpasswd -a $add_sudo sudo && echo "Added $add_sudo to sudo group"
done;

echo "Removing unwanted sudoers…"
for sudo_user in $(grep "^sudo:" /etc/group | cut -d: -f4 | tr "," " "); do
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
' >> /cp/limitsudo.sh; chmod a+x /cp/limitsudo.sh;
```

passwdch.sh

```bash
echo '
for username in $(grep -v "\:\!\:" /etc/shadow | grep -v "\:\*\:" | cut -d: -f1); do
  if [[ $username != "cyberpatriot" ]]; then
    echo "$username:FortniteMinecraft42!" | chpasswd;
    echo "Changed password for $username";
  fi;
done
' >> /cp/passwdch.sh; chmod a+x /cp/passwdch.sh;
```

Disable guest access
```bash
sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" > /etc/lightdm/lightdm.conf.d/50-no-guest.conf'
```

Prevent root login with SSH
```bash
```

Enable firewall
```bash
sudo apt install ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw reload
sudo ufw enable
```

Set password policies
```bash

```

#### Additional Checks

Services
```bash
service --status-all
sudo netstat -ntulp
```

more stuff at sumwonyuno.github.io/cp-lockdown
