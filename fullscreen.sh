#!/bin/bash

w=1920	# Width of target window
h=1080	# Height of target window
x=0	# X offset of target window
y=0	# Y offset of target window

wmf="/tmp/.wmctrl_l"
if [ -e "$wmf" ]; then
	echo"Program already running!"
fi
wmctrl -l >"$wmf"
n=0; while IFS= read -r line; do
	let n=n+1
	echo "$n: $line"
done <"$wmf"
echo -n "Please select a window: "
sel=""; read -r nsel
n=0; while IFS= read -r line; do
	let n=n+1
	if [ $n -eq $nsel ]; then
		sel="$line"
		break
	fi
done <"$wmf"; rm "$wmf"
if [ -z "$sel" ]; then
	echo "Invalid selection"
	exit 1
else
	echo "Selected: $sel"
	id=`echo "$sel" | awk -F ' ' '{print $1}'`
	echo "ID: $id"
fi

c() {
	echo $@; $@
}
c wmctrl -v -i -r $id -e 0,$x,$y,$w,$h -b toggle,fullscreen
#c wmctrl -v -i -r $id 
	
