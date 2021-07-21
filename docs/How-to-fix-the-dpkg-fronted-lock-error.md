Error message
E: Could not get lock /var/lib/dpkg/lock-frontend - open (11: Resource temporarily unavailable)
E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), is another process using it?

1. `sudo killall apt apt-get`
2. delete directories if nothing appeared in step 1
   - `sudo rm /var/lib/apt/lists/lock`
   - `sudo rm  /var/cache/apt/archives/lock`
   - `sudo rm /var/lib/dpkg/lock*`
3. `sudo dpkg --configure -a`
4. `sudo apt update`

