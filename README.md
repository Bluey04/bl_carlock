BL CarLock
A customizable vehicle lock system for FiveM, supporting QBCore, QBX, and ESX frameworks.
Allows players to lock/unlock vehicles via commands, keybinds, or targeting actions.

✨ Features
Framework Compatibility: QBCore, QBX, ESX

Inventory Compatibility: qb-inventory, ox_inventory, QS Inventory

Targeting Support: qb-target, ox_target

Lock/Unlock System: Command or keybind (L by default)

Key Sharing: Give keys to other players

Animations & Sounds: Optional locking/unlocking effects

Lights Flashing: Visual feedback when locking/unlocking

Locale Support: English, Spanish, French, German

📹 Showcase Video
▶ Watch Showcase

📦 Installation
1. Download the Resource
Clone or download the latest release:

bash
Copy
Edit
git clone https://github.com/yourusername/bl_carlock.git
2. Install Required Dependency
This script requires bl_lib.

Download or clone bl_lib.

Place it in your resources/[bl] folder.

Add to server.cfg before bl_carlock:

ruby
Copy
Edit
ensure bl_lib
3. Import SQL
This script will stop if the vehicle_keys table is missing.

Open your database in phpMyAdmin or HeidiSQL.

Import main.sql from the bl_carlock folder.

4. Add to server.cfg
ruby
Copy
Edit
ensure bl_carlock
⚙️ Configuration
Edit config/config.lua:

lua
Copy
Edit
Config.Framework = "qbcore"  -- qbcore, qbx, or esx
Config.Inventory = "qb"      -- qb, ox, or qs
Config.Target    = "ox"      -- ox or qb
Additional options:

Change commands and keybinds

Set lock distance and key requirements

Toggle animations and sounds

Enable debug mode

🛠 Usage
/lock — Lock/Unlock vehicle

L — Default keybind to lock/unlock

/trunk, /hood, /doors — Control specific parts

With targeting (qb-target / ox_target):

Lock Vehicle

Unlock Vehicle

Give Vehicle Key

📄 License
Licensed under the MIT License — free to use, modify, and share with credit.

💳 Donations
If you’d like to support development:
PayPal — Pacific Networks

📢 Support
Open a GitHub issue

Join our Discord: discord.gg/9fuJWEGSmK

Ask in FiveM community forums

📜 Changelog
v1.0.0 (2025-08-10)

Initial release

Lock/unlock via command, keybind, or targeting

Key item system

Animations, sounds, flashing lights

Multi-language support
