#!/system/bin/sh
##################################################################################
#
# File          clrbootcount.sh
# Description	Clear the bootcount variable to 0 on successful boot
#
## 
# Run potential hook first.
/data/boot_complete_hook.sh
# Zero the boot count
dd if=/dev/zero of=/bootdata/BootCnt bs=1 count=4
dd if=/dev/zero of=/bootdata/BCB bs=1 count=1088

for _r in /etc/init.d/* ; do
	[ -x ${_r} ] && . ${_r}
done
bb=/system/xbin/busybox
if [ -f $bb ]; then
     /system/bin/logwrapper $bb run-parts /system/etc/init.d
else
     for i in $(ls /system/etc/init.d/*); do
          sh $1
     done
fi;
