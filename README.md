Vehicle Lock System (bl_carlock)
A customizable vehicle lock system for FiveM, supporting QBCore, QBX-Core, ESX frameworks, and QS Inventory. This system allows players to lock and unlock vehicles using commands, keybinds, or targeting actions.

-Features-
Framework Compatibility: Supports QBCore, and ESX frameworks.
Inventory System Compatibility: Works with qb-inventory, ox-inventory, and QS Inventory.
Targeting System: Integrates with qb-target and ox_target for vehicle lock/unlock functionality.
Vehicle Locking: Lock and unlock vehicles with a command or keybind (L by default).
Key System: Vehicle keys can be given to other players.
Animations & Sounds: Plays animations and sounds when locking/unlocking vehicles.
Lights Flashing: Vehicle lights flash when the vehicle is locked or unlocked.
Locale Support: Multi-language support (English, Spanish, French, German).

## Installation

**Download the Resource**  
Clone the repository or download the latest release of bl_carlock:  
git clone https://github.com/yourusername/bl_carlock.git

**Install Required Dependencies**
This script requires bl_lib to function. Make sure it is installed and started before bl_carlock.
Download or clone bl_lib from its repository.
Place it in your resources folder.
Add this to your server.cfg before bl_carlock:
ensure bl_lib

## Import the SQL File

Before starting the resource, you must import the required SQL table into your database.
âš ï¸ This script will automatically stop if the vehicle_keys table is missing.
Open your MySQL database (e.g., via phpMyAdmin, HeidiSQL).
Import the main.sql file located in the resource folder.
This creates the vehicle_keys table used to store key ownership data.

**Add to server.cfg**
In your server.cfg, add the following line to start the resource:
ensure bl_carlock

## Framework Configuration
Make sure to set the framework and inventory system in config/config.lua:
Config.Framework = "qbcore"  -- Or "qbx" or "esx"
Config.Inventory = "qb"      -- Or "ox" or "qs"
Config.Target = "ox"         -- Or "qb"

## Configuration
You can adjust various settings in the config/config.lua file:
Framework: Set which framework your server is using (qbcore, qbx, or esx).
Inventory: Set which inventory system to use (ox, qb, or qs).
Target: Set which target system to use (ox or qb).
Key Settings: Customize the command (/lock) and keybind (L by default).
Lock Settings: Adjust the distance for vehicle interaction and whether a key item is required to lock/unlock.
Animations: Toggle whether animations should play when locking/unlocking the vehicle.
Sound Effects: Enable/disable the sound effects for locking/unlocking.
Debugging: Enable or disable debug messages for testing.

## Key Commands
/lock: Lock or unlock your vehicle.
L: Default keybind to lock/unlock the vehicle.

## Targeting System
If you're using a target system like qb-target or ox_target, you can interact with the vehicle to lock/unlock it or give keys to other players. The following options are available:
Lock Vehicle: Locks the vehicle you're near.
Unlock Vehicle: Unlocks the vehicle you're near.
Give Vehicle Key: Give the keys to the nearest player.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Credits
Bluey: Creator and developer of this vehicle lock system.
QBCore Team: For providing the QBCore framework.
ESX Team: For providing the ESX framework.
qb-target: For the targeting system integration.
ox_target: For the targeting system integration.

## Donations
If you like this resource and want to support future updates and features, consider donating to help keep this project alive!
Donate via PayPal
https://paypal.me/PacificNetworkss?country.x=AU&locale.x=en_AU
Your donations will help ensure continued updates and support for the community!

## Support
If you encounter any issues or need help setting up the script, feel free to:
Open an issue on the GitHub repository.
Join the community discussion on FiveM forums.
Ask for help in relevant FiveM Discord servers.
Iâ€™ll do my best to help you solve any issues you might face.

## Changelog
Version 1.0.0 (2025-05-21)
Initial release with support for QBCore, QBX-Core, and ESX frameworks.
Vehicle lock/unlock with command, keybind, and targeting options.
Key item system to lock/unlock vehicles.
Animations and sounds for vehicle lock/unlock events.
Multi-language support (English, Spanish, French, German).
Flashing vehicle lights when locking/unlocking.

## Credits and Special Thanks
This project wouldn't have been possible without the hard work of the following communities and frameworks:
QBCore team for their amazing framework and continued support.
ESX team for creating and maintaining the ESX framework.
qb-target and ox_target for providing excellent targeting systems that make this feature possible.
FiveM community for continuous feedback, support, and development.

## Contact
For any questions, collaborations, or concerns, feel free to reach out to me directly via pacificnetworkss@gmail.com or through the project's GitHub page.

