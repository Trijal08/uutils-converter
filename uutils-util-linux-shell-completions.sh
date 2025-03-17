commandsuu="blockdev ctrlaltdel dmesg fsfreeze last lscpu lslocks lsmem mesg mountpoint renice rev setsid"

for i in $commandsuu; do
	cargo run completion $i bash > /usr/share/bash-completion/completions/$i
	cargo run completion $i zsh > /usr/share/zsh/site-functions/_$i
done
