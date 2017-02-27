
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
blacklist /srv
blacklist /sys
blacklist /var
#blacklist /opt
#private-etc java-8-openjdk/amd64/jvm.cfg
