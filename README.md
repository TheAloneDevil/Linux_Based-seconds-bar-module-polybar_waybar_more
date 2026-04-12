# Enhanced WiFi Menu & Status Modules

![WiFi Menu](Screenshots/4.png)

![Network Info](Screenshots/2.png)

<p align="center">
<img src="Screenshots/3.png" width="45%">
</p>

This is an updated version of the polybar themes compared to the original at https://github.com/adi1090x/polybar-themes - featuring modern enhancements like More scripts, More day to day use Models and more.

---

This package provides enhanced WiFi menu and status modules for Linux systems using NetworkManager.

## What Does This Do?

This provides two main components:

1. **wifimenu-podobu** - A WiFi connection menu that works with any launcher (wofi, rofi, etc.)
2. **network-wifi.sh** - A status module to display WiFi connection status (works with polybar, waybar, or similar)

## Files Included

1. **wifimenu-podobu** - Main WiFi menu script
2. **network-wifi.sh** - WiFi status display script
3. **user_modules.ini** - Module configuration (for polybar/waybar users)
4. **README.md** - This file

---

## Features

### wifimenu-podobu Features

- Network scanning with signal strength indicators
- Saved network detection with indicator icon (󱣪)
- Disconnect by pressing Enter on connected network
- Refresh cooldown (15 seconds) with message
- SSID truncation for long network names (>70 chars)
- **"Try Again" feature** for saved networks with changed passwords (avoids system password dialog)
- Network Information menu with detailed network stats
- Auto Connection toggle to automatically connect to available saved networks
- Network count display on Refresh Networks option
- **Remove All Saved Networks** option in Known Connections (keeps current connection)
- **Back** option in Known Connections menu
- Works with any launcher (wofi, rofi, dmenu, etc.)
- Cherry theme color menu

### How "Try Again" Works (Avoiding System Password Dialog)

When connecting to a saved network where the password has changed, the OS may show a system password dialog (like KDE's). This script handles it gracefully:

1. **First Attempt**: Try to connect to the saved network using nmcli
2. **Detect Failure**: If connection fails (wrong password), the script:
   - Deletes the saved connection from NetworkManager
   - Saves the network name to a pending file (`.pending_network`)
   - Exits with code 42 to restart the menu
3. **Show as Try Again**: The network now appears in the menu with "(Try Again)" suffix
4. **User Re-enters Password**: User selects it and enters the new password
5. **Connect Fresh**: The script connects to the network with the new password and saves it

This way, users don't get stuck at system dialogs - they can re-enter passwords through the menu itself.

### network-wifi.sh Features

- Shows current connection with SSID and download speed
- Different icons based on connection state:
  - **Offline**: 󰖪 + "Offline"
  - **Connected but no internet**: 󰤣 + SSID + speed
  - **Connected with internet**:  + SSID + speed
  - **Connecting**: Cycles through 󰤯 󰤟 󰤢 󰤥 󰤨 (every half second)
- Real-time download speed calculation
- Click to open WiFi menu (when used with polybar/waybar)

### Menu Options

- **Disable Wi-Fi** - Turn off WiFi
- **Refresh Networks** - Rescan networks (shows network count [n])
- **Network Information** - View detailed network info
- **Auto Connection** (Toggle: 󰈄/󰛅) - Auto-connect to saved networks when not connected
- **Close the menu** - Exit menu
- Network list - Available WiFi networks with signal bars

### Icons Used

- 󰤪 󰤤 󰤡 - Secured networks (signal strength)
- 󰤨 󰤢 󰤟 - Open networks (signal strength)
- 󱣪 - Saved network indicator
- 󰑙 - Refresh icon
- 󰈔 - Network info icon
- 󰤣 - Connected but no internet
-  - Connected with internet
- 󰖪 - Offline
- 󰤯 󰤟 󰤢 󰤥 󰤨 - Connecting animation
- 󰈄 - Auto connection OFF
- 󰛅 - Auto connection ON

---

## Requirements

- Linux operating system
- NetworkManager (nmcli command)
- A launcher program (wofi, rofi, dmenu, wmenu, or bemenu)
- Nerd Fonts for icons
- For network-wifi.sh status: polybar, waybar, or similar (optional)

---

## Installation (Step by Step for Rookies)

### Step 1: Choose Where to Put Your Scripts

Decide where you want to store your scripts. For this example, we'll use `~/wifi-scripts/`.

Replace `~/YourPath/` in all file paths with your chosen directory (e.g., `~/wifi-scripts/`).

### Step 2: Create the Directory

```bash
mkdir -p ~/wifi-scripts
```

### Step 3: Copy the Files

Copy the downloaded files to your new directory:
```bash
cp wifimenu-podobu ~/wifi-scripts/
cp network-wifi.sh ~/wifi-scripts/
cp user_modules.ini ~/wifi-scripts/
```

### Step 4: Make Scripts Executable

```bash
chmod +x ~/wifi-scripts/wifimenu-podobu
chmod +x ~/wifi-scripts/network-wifi.sh
```

### Step 5: Create a Wrapper Script (Optional but Recommended)

Create a file called `wifimenu.sh`:
```bash
#!/bin/bash
while true; do
    ~/wifi-scripts/wifimenu-podobu "$@"
    exit_code=$?
    if [ $exit_code -ne 42 ]; then
        break
    fi
done
```

Make it executable:
```bash
chmod +x ~/wifi-scripts/wifimenu.sh
```

### Step 6: Update Paths in user_modules.ini

Open `user_modules.ini` and update all paths from `~/YourPath/` to your actual path.

### Step 7: Add to Polybar/Waybar

Add the module to your bar config and copy the user_modules.ini content.

### Step 8: Restart Bar

---

## Customization Guide

### Changing Script Locations

1. **wifimenu-podobu**: Uses `SDIR="$(dirname "$0")"` to find its own location.

2. **network-wifi.sh** (line 5): Change the speed file location:
   ```bash
   SPEED_FILE="$HOME/.cache/wifi-speed.data"
   ```

3. **user_modules.ini**: Update all paths.

### Key Directory References

| File | Line | Description | Default | Change To |
|------|------|-------------|---------|-----------|
| wifimenu-podobu | ~ (SDIR) | Log, pending network files | Script directory | `$HOME/YourPath` |
| network-wifi.sh | 5 | Speed data file | `$HOME/.cache/wifi-speed.data` | `~/YourPath/wifi-speed.data` |

---

## Troubleshooting

### WiFi menu doesn't open
- Check path is correct
- Make sure script is executable

### Networks not showing
- `nmcli radio wifi on`
- `nmcli device wifi list`

### Icons not showing
- Install Nerd Fonts

---

## License & Credits

This is a customized version of the original wifimenu created by Jesús Arenas (podobu).  
I, Anindra Mohan Trivedi, have modified it to add modern features and improvements.

See the original project: https://github.com/podobu/wifimenu