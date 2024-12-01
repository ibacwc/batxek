# batxek
Battery checker (daemon?) for linux utilising acpi && notify-send and sleep.

# Installation
Example installation (using void linux's xbps. Just replace it with your package manager)
```
sudo xbps-install -S libnotify acpi
chmod +x batxek.sh # (You did download the file, right?)
./batxek.sh & disown
```
very easy to make into a service.  
  
Works on my machine, closed::wontfix
