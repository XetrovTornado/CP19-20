rem Set up 5 users, each with a different password
net user drag noGard99-cyber /add
net user ben trunk3467-cyber /add
net user squishy RaisinMuffin+3 /add
net user sunless darkWindow+13 /add
net user coconut PurpleTarp.012 /add

rem Add 3 of them to the administrator group
net localgroup administrators drag /add
net localgroup administrators ben /add
net localgroup administrators sunless /add

rem Echo 5 different messages
echo "Hello, it works!"
echo "( ͡° ͜ʖ ͡°)"
echo "Over there!"
echo "Windows 10 is people!"
echo "Uninstalling System32..."

rem Use curl to visit 3 different websites
curl "https://netwayfind.github.io/cp-lockdown/"
curl "https://reddit.com/r/ProgrammerHumor/"
curl "https://stackoverflow.com"

pause
