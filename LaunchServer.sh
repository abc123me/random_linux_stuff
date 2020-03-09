#!/bin/bash

server_dir="/home/jeremiah/ftb_inf_evo/"
remote_port="1234"
remote_ip="0.0.0.0"
log_file="$server_dir/latest_log"
jar="forge-1.7.10-10.13.4.1614-1.7.10-universal.jar"
mem="-Xmx16G -Xms8G"
in_fifo="$server_dir/fifo.in"
out_fifo="$server_dir/fifo.out"
cmd="./ServerStart.sh"

echo -e "\e[1;33mStarting high performance modded minecraft server\e[0m"
echo "Server: $cmd"


rm -f "$out_fifo" "$in_fifo"
mkfifo "$out_fifo"; #Output FIFO, server -> netcat
mkfifo "$in_fifo";  #Input FIFO, netcat -> server
echo "FIFOs created: $in_fifo, $out_fifo"

if [ -e "$log_file" ]; then cp "$log_file" "${log_file}.last"; fi
touch "$log_file"
echo "Logfile created: $log_file"

# Output of server goes into netcat, netcat is seperate process
# Output of netcat goes into the input FIFO
nc -kl "$remote_ip" "$remote_port" <"$out_fifo" >"$in_fifo" & # Start as seperate process, otherwise it will block
pidA=$! # Get PID, we need to kill netcat later
echo -e "\e[1;32mRemote server probably started! PID: $pidA Hostname: $remote_ip:$remote_port\e[0m"
# Input FIFO goes to the server, both output and error of server go to both the output FIFO and logfile
$cmd <"$in_fifo" 2>&1 | tee "$log_file" "$out_fifo" > /dev/null # This guy dominates main thread for a bit, pipe server output into /dev/null
# When finished, kill netcat
if [ -d "/proc/$pidA" ]; then kill $pidA; fi
# Cleanup
rm -f "$out_fifo" "$in_fifo"
