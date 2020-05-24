# Set up 5 users, each with different passwords
useradd -m -s /bin/bash drag
useradd -m -s /bin/bash ben
useradd -m -s /bin/bash squishy
useradd -m -s /bin/bash sunless
useradd -m -s /bin/bash coconut
echo "password for drag"
passwd drag
echo "password for ben"
passwd ben
echo "password for squishy"
passwd squishy
echo "password for sunless"
passwd sunless
echo "password for coconut"
passwd coconut

# Add 3 users to administrator
gpasswd -a drag sudo
gpasswd -a ben sudo
gpasswd -a sunless sudo

# Echo 5 different messages
echo "Hello, it works!"
echo "( ͡° ͜ʖ ͡°)"
echo "Over there!"
echo "Windows 10 is people!"
echo "Uninstalling System32..."

# Use curl to visit 3 different websites
curl "https://netwayfind.github.io/cp-lockdown/"
curl "https://reddit.com/r/ProgrammerHumor/"
curl "https://stackoverflow.com"
