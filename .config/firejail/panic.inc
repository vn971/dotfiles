
caps.drop all
ipc-namespace
netfilter
nogroups
nonewprivs
noroot
#nosound
private-dev
seccomp
whitelist ~/abc12345


#whitelist ~/.cache/fontconfig
#read-only ~/.cache/fontconfig

blacklist /mnt
blacklist /opt
blacklist /srv
blacklist /sys
blacklist /var
#private-etc java-8-openjdk/amd64/jvm.cfg

