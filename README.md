# FFXIV ACT Log Reader

## Description:
Read log output from Advanced Combat Tracker for FFXIV and convert them into readable chatlogs.

## Requirements:
* FFXIV (duh)
* [AdvancedCombatTracker](https://github.com/EQAditu/AdvancedCombatTracker)
* [ripgrep](https://github.com/BurntSushi/ripgrep)

## Usage:

1. Put the `log-converter.sh` file in ACT's output folder, e.g.  
    `%AppData%\Advanced Combat Tracker\FFXIVLogs\`
2. Make the script executable:  
    `chmod +x log-converter.sh`
2. Run `log-converter.sh` to convert all files, or add individual files as arguments.
3. Resulting logs are output to the `output/` directory.
