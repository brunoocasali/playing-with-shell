# First you'll need to see what devices is mounted in your computer.
$ mount

# Second you'll need to umount this devices with:
$ umount /dev/sdb1 # for example

# Then you ready to continue the process!
# Where is the 'memtest.img' is the image what you want to write 
# and the 'sd' is the device destination
$ sudo dd if=memtest.img of=/dev/sd? && sync

# To return to the zero status use:
$ sudo dd if=/dev/zero of=/dev/sd?

# And format with ntfs type:
$ sudo mkfs.ntfs -n data /dev/sd?


## FOR WINDOWS FILES IN MACBOOK

# List the units you have (will be probably the disk2)
$ diskutil list

# Format the usb drive in a format that MS DOS understand
$ diskutil eraseDisk MS-DOS "WIN10" GPT disk2

# Mount the downloaded windows iso image
$ hdiutil mount ~/Downloads/windows.iso

# Copy all iso files to mounted disk
$ rsync -ah --progress /Volumes/CCCOMA_X64FRE_PT-PT_DV9/* /Volumes/WIN10
