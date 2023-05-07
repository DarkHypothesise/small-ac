# small-ac

README for FiveM script:

Introduction:
This script is designed to prevent cheating in your FiveM server by detecting blacklisted and limited triggers. It works by adding event handlers for the specified triggers and printing a message to the console when one is detected.

Installation:

Download the script and save it to your server's resources folder.

Add 'start anticheat' to your server.cfg file.

Modify the 'BlacklistedTrigger' and 'LimitedTrigger' variables in the script to include the triggers you want to detect.

![image](https://user-images.githubusercontent.com/107435103/236684685-61b8370e-8d06-45b9-a4b2-f63c0545f8b7.png)

Restart your FiveM server and the script will be active.


Usage:
Once the script is installed and running, it will automatically detect any blacklisted or limited triggers that are executed by players in your server. If a trigger is detected, a message will be printed to the console with the name of the trigger and the type of detection (blacklisted or limited).

Configuration:
To configure the script, modify the 'BlacklistedTrigger' and 'LimitedTrigger' variables in the script. These variables are arrays that contain the names of the triggers you want to detect. You can add or remove triggers as needed.

Important Note:
This script is designed as a tool to help prevent cheating in your FiveM server, but it is not foolproof. It is recommended to use other anti-cheat measures in conjunction with this script to ensure a fair and fun gameplay experience for all players.
