# (c) 2023 Luana Neder
# Licensed under MIT license
# run at your own risk, this may break your system
# run with sh, I cant add a shebang bc env is part of util-linux and you won't have that during a period of time
# make a snapshot with snapper before: 'sudo snapper create --description 'before-uutils' --userdata important=yes -t pre'
# and after: 'sudo snapper create --description 'after-uutils' --userdata important=yes -t post --pre-number [NUMBER OF THE SNAPSHOT THAT WAS MADE BY THE PREVIOUS SNAPPER RUN, CHECK WITH 'sudo snapper list']'
# before running this, install uutils to /usr/bin  (compile and copy the generated util-linux binary to /usr/bin)
# Run this first with sudo sh, then run 'sudo rpm -e --allmatches --nodeps util-linux', and then run this with sudo sh once again.
# Only reboot AFTER running this after you remove util-linux with rpm.
# Remember to install the empty .deb/.rpm util-linux metapackage with your designated package manager and then versionlock util-linux.

commandsuu="blockdev chcpu ctrlaltdel dmesg fsfreeze last lscpu lslocks lsmem mcookie mesg mountpoint renice rev setsid"

for i in $commandsuu; do
	rm -f /usr/bin/$i
	ln -s /usr/bin/util-linux /usr/bin/$i
	rm -f /bin/$i
	ln -s /bin/util-linux /bin/$i
done

echo "Completed successfully!"
