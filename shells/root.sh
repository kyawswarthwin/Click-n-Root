export PATH=/data/local/tmp:$PATH

busybox mount -o remount,rw /system

dd if=/data/local/tmp/busybox of=/system/xbin/busybox
chown root.root /system/xbin/busybox
chmod 04755 /system/xbin/busybox
/system/xbin/busybox --install -s /system/xbin

dd if=/data/local/tmp/su of=/system/bin/su
chown root.shell /system/bin/su
chmod 06755 /system/bin/su
rm /system/xbin/su
ln -s /system/bin/su /system/xbin/su

dd if=/data/local/tmp/Superuser.apk of=/system/app/Superuser.apk
chown root.root /system/app/Superuser.apk
chmod 644 /system/app/Superuser.apk
