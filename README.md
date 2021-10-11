# debian-buster_bluetooth_aptX-LDAC
Script installing aptX and LDAC codecs for bluetooth devices from Debian 10 buster.
(Despite the name) It finally also works for *bullseye* and *bookworm (='testing' atm.)*. (This uses the method introduced with the buster-backport-repos to generate apt-/dpkg-compatible packages)

Choose backports turned on to install as deb-packages.



What does it do?
-
- Install the required sofware packages
- Backup the original libraries as <libname>.bak in their original folder.
- Clone the required sources from the EHfive project site and their submodules from pulseaudio and google-android repos
- Compile them 
- Install them
  - with backports turned on: as deb-packages named "libldac" and "pulseaudio-module-bluetooth" (uninstall possible)
  - w/o backports: normal 'make install'
  - for Debian deleases 'bullseye' and 'bookworm' the dpkg-package method is used, as packages needed are available in th repos by default
  
For more details see the comments in the script.



