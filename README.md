# AngryBirds
This version uses decompiled lua files from android. (im using android lua files because they have debug info which helps decompiler a lot to produce working code. starting from 2.3.0 lua files don't have debug info)

# Version
Lua Files: 2.2.0
Assets: 2.3.0
AngryBirds.exe: 2.2.0

# Setup
1. Change in all bat files "set openssl="Path to your openssl.exe""
2. Run buildLevels.bat to build all levels in levelsSrc folder (only one time)
3. Run build&run.bat to build all scripts in scriptsSrc folder, loadlist.lua in images and to Run Game (run after every modification in scriptsSrc or loadlist.lua)

# TODO
- Port 2.3.0 scripts/scripts_common structure
