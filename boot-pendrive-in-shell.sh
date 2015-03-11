# First you'll need to see what devices is mounted in your computer.
$ mount
# Second you'll need to umount this devices with:
$ umount /dev/sdb1 # for example
# Then you ready to continue the process!
# Where is the 'memtest.img' is the image what you want to write 
# and the 'sd' is the device destination
$ sudo dd if=memtest.img of=/dev/sd? && sync
