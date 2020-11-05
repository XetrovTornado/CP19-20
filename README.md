# CyberPatriots19-20
Scripts for McK. HS CP19-20

Note: to copy and paste code to/from a terminal, use `Ctrl+Shift+C` and `Ctrl+Shift+V`

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
sudo cut -d: -f1 /etc/passwd | grep -v -E '(root|daemon|bin|sys|sync|games|man|lp|mail|news|uucp|proxy|www-data|backup|list|irc|gnats|nobody|libuuid|syslog|messagebus|colord|lightdm|whoopsie|avahi-autoipd|avahi|usbmux|kernoops|pulse|rtkit|speech-dispatcher|dispatcher|hplip|saned|ubuntu|_apt|uuidd|dnsmasq|geoclue|gnome-initial-setup|gdm|vboxadd|sshd)'
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

Log in to sudo
```
sudo echo "Logged in as sudo"
```

Run these to create the directory /cp (this is where all scripts will go)
```bash
sudo mkdir /cp
sudo chmod a+rwx /cp
```

Program install and remove
```bash
sudo apt remove -y nmap zenmap wireshark john ophcrack

sudo apt install -y ufw libpam-cracklib git
```

~~Run scripts with `sudo bash /cp/<script> <parameters>`~~
Copy-pasting the Users code will run the script for you
Tip: copy the user list in the readme and paste it into an online sorting app (such as https://pinetools.com/sort-list)

Users
```bash
echo '
for username in $(cut -d: -f1 /etc/passwd | grep -v -E "root|daemon|bin|sys|sync|games|man|lp|mail|news|uucp|proxy|www-data|backup|list|irc|gnats|nobody|libuuid|syslog|messagebus|colord|lightdm|whoopsie|avahi-autoipd|avahi|usbmux|kernoops|pulse|rtkit|speech-dispatcher|dispatcher|hplip|saned|ubuntu|_apt|uuidd|dnsmasq|geoclue|gnome-initial-setup|gdm|vboxadd|sshd|mysql)"); do
    echo "Is $username a permitted user?"
    select keepuser in "Yes" "No"; do
        case $keepuser in
            Yes ) 
                echo "Is $username an administrator?"
                select makeadmin in "Yes" "No"; do
                    case $makeadmin in 
                        Yes ) gpasswd -a $username sudo; break;;
                        No ) gpasswd -d $username sudo; break;;
                    esac
                done
                echo "$username:FortniteMinecraft42!" | chpasswd; break;;
            No ) userdel $username && echo "Deleted $username"; break;;
        esac
    done
done
' > /cp/userchecks.sh; chmod a+x /cp/userchecks.sh; sudo bash /cp/userchecks.sh;
                
```

Disable guest access
```bash
sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" > /etc/lightdm/lightdm.conf'
```

Prevent root login with SSH
```bash
sudo sed -i 's/PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config
```

Enable firewall
```bash
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw reload
sudo ufw enable
```

Set password policies
```bash
sudo sed -ri 's/^(password\s*requisite\s*pam_cracklib\.so.*)$/\1 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1/' /etc/pam.d/common-password
sudo sed -ri 's/^(password.*pam_unix\.so.*)$/\1 remember=5 minlen=8/' /etc/pam.d/common-password
sudo sed -ri 's/PASS_MAX_DAYS\s*[0-9]*/PASS_MAX_DAYS 90/' /etc/login.defs
sudo sed -ri 's/PASS_MIN_DAYS\s*[0-9]*/PASS_MIN_DAYS 10/' /etc/login.defs
sudo sed -ri 's/PASS_WARN_AGE\s*[0-9]*/PASS_WARN_AGE 7/' /etc/login.defs
sudo echo "auth required pam_tally2.so deny=5 onerr=fail unlock_time=30" >> /etc/pam.d/common-auth
```

Secure permissions
```bash
sudo chmod u=rw,go= /etc/shadow
sudo chmod u=rw,go= /etc/sudoers
sudo chmod u=rw,go=r /etc/passwd

sudo passwd -l root
```

#### Additional Checks

**Services**
```bash
ps
service --status-all
sudo netstat -ntulp
```
Ubuntu 16+: `systemctl disable <service>`
Ubuntu 14 or earlier: `update-rc.d -f <service> remove`

**Cron Jobs**
```bash
ls -a "/etc/cron*"
```
Default cron jobs:
```
/etc/crontab

/etc/cron.d:
anacron  john  .placeholder  popularity-contest

/etc/cron.daily:
0anacron  apport      bsdmainutils      dpkg       man-db   passwd        popularity-contest      upstart
apache2   apt-compat  cracklib-runtime  logrotate  mlocate  .placeholder  update-notifier-common

/etc/cron.hourly:
.placeholder

/etc/cron.monthly:
0anacron  .placeholder

/etc/cron.weekly:
0anacron  fstrim  man-db  .placeholder  update-notifier-common
```
Compare exact cron jobs:
```bash
mkdir /cp/CurrentCron
sudo cp /etc/cron* /cp/CurrentCron
sudo diff -r /cp/CurrentCron /cp/CronCompare
```

# Updates

```bash
sudo apt update
sudo apt upgrade
```

#### Troubleshooting 

Could not lock /var/lib/dpkg/lock-frontend
```bash
sudo killall apt apt-get

sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock*
sudo dpkg --configure -a
sudo apt update
```

more stuff at [sumwonyuno.github.io/cp-lockdown](https://sumwonyuno.github.io/cp-lockdown)


passwdch.sh

```bash
echo '
for username in $(grep -v "\:\!\:" /etc/shadow | grep -v "\:\*\:" | cut -d: -f1); do
  if [ "$username" != "cyberpatriot" ]; then
    echo "$username:FortniteMinecraft42!" | chpasswd;
    echo "Changed password for $username";
  fi;
done
' > /cp/passwdch.sh; chmod a+x /cp/passwdch.sh;
```
