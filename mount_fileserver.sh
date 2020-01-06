
user="$USER"
share="Storage"
ip="$1"
echo mount -t cifs -o user="$user" "//$ip/$share" /media/jeremiah/mnt
sudo mount -t cifs -o user="$user" "//$ip/$share" /media/jeremiah/mnt
