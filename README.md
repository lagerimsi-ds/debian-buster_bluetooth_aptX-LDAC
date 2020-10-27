# debian-buster_bluetooth_aptX-LDAC
Script installing aptX and LDAC codecs for bluetooth devices on Debian 10 buster.

Choose backports turned on to install as deb-packages.



What does it do?
-
- Install the required sofware packages
- Backup the original libraries as <libname>.bak in their original folder.
- Clone the required sources from the EHfive project site and their submodules from pulseaudio and google-andriod repos
- Compile them 
- Install them
  - with backports turned on: as deb-packages named "libldac" and "pulseaudio-module-bluetooth" (uninstall possible)
  - w/o backports: normal 'make install'
  
For more details see the comments in the script.



