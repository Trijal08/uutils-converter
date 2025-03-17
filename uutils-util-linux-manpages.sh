commandsuu="blockdev ctrlaltdel dmesg fsfreeze last lscpu lslocks lsmem mesg mountpoint renice rev setsid"

for i in $commandsuu; do
	# Check if the directory exists
	if [ ! -d /usr/local/man/man1/ ]; then
		# Create the directory if it doesn't exist
		mkdir -p /usr/local/man/man1/
	fi
	cargo run manpage $i > /usr/local/man/man1/$i.1
done
