commandsuu="blockdev ctrlaltdel dmesg fsfreeze last lscpu lslocks lsmem mesg mountpoint renice rev setsid"


for i in $commandsuu; do
    echo 'Provides:       '/usr/bin/$i
    echo 'Provides:       '/bin/$i
done
