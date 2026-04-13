# Enhanced WiFi Menu for Linux Desktop

This package provides enhanced WiFi menu and status modules for Linux desktop.

## Files Included

1. **wifimenu-podobu** - Main WiFi menu script
2. **network-wifi.sh** - WiFi status display script
3. **user_modules.ini** - Module configuration
4. **README.md** - This file

---

## Features

- Network scanning with signal strength
- Saved network detection
- Try Again feature for changed passwords
- Auto Connection toggle
- Network Information menu
- Remove All Saved Networks option
- Works with rofi, wofi, dmenu

---

<p align="center">
  <img src="Screenshots/4.png" width="400"/>
  <img src="Screenshots/2.png" width="400"/>
  <img src="Screenshots/3.png" width="400"/>
</p>

---

## Installation

### Step 1: Create Directory
```bash
mkdir -p ~/.config/polybar/forest/scripts
```

### Step 2: Copy Files
```bash
cp wifimenu-podobu ~/.config/polybar/forest/scripts/
cp network-wifi.sh ~/.config/polybar/forest/scripts/
cp user_modules.ini ~/.config/polybar/forest/scripts/
```

### Step 3: Make Executable
```bash
chmod +x ~/.config/polybar/forest/scripts/wifimenu-podobu
chmod +x ~/.config/polybar/forest/scripts/network-wifi.sh
```

### Step 4: Create Wrapper (Optional)
Create `~/.config/polybar/forest/scripts/wifimenu.sh`:
```bash
#!/bin/bash
while true; do
    ~/.config/polybar/forest/scripts/wifimenu-podobu "$@"
    [ $? -ne 42 ] && break
done
```
Then make it executable:
```bash
chmod +x ~/.config/polybar/forest/scripts/wifimenu.sh
```

### Step 5: Update Paths in user_modules.ini
Open `user_modules.ini` and replace:
- Line 5: Change `~/YourPath` to your actual scripts path (e.g., `~/.config/polybar/forest/scripts`)
- Line 10: Change `~/YourPath` to your actual scripts path
- Line 11: Change `~/YourPath` to your actual scripts path

Example after editing:
```ini
exec = ~/.config/polybar/forest/scripts/network-wifi.sh
label = "%{A1:~/.config/polybar/forest/scripts/wifimenu.sh &:}%output%%{A}"
click-left = ~/.config/polybar/forest/scripts/wifimenu.sh
```

### Step 6: Enable Module in polybar config
Open your polybar config file (e.g., `~/.config/polybar/forest/config`) and add:
```ini
[module/network-wifi]
include-file = ~/.config/polybar/forest/scripts/user_modules.ini

[bar/top]
modules-left = network-wifi
```
Adjust `modules-left` or `modules-right` based on where you want the WiFi module to appear.

---

## Requirements

- Linux desktop
- NetworkManager
- rofi or wofi or dmenu
- Nerd Fonts

---

## Contribution

This is a customized version of the original wifimenu created by Jesús Arenas (podobu). I, Anindra Mohan Trivedi, have modified it to add modern features and improvements.

I claim no rights to the original work — only to provide additional support and styling.

## Credits

Based on wifimenu by Jesús Arenas (podobu)