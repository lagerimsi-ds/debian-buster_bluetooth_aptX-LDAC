# debian-buster_bluetooth_aptX-LDAC
Script installing aptX and LDAC codecs for bluetooth devices on Debian 10 buster.

To install as deb-packages backports must be enabled to be able to use checkinstall.

What does it do?

- Install the required sofware packages
- Clone the required sources from the EHFive project site.
- Compile them 
- install them
  - with backports turnes on: as deb-packages named "libldac" and "pulseaudio-module-bluetooth"
  - w/o backports: normal make install
  
For more details see the comments in the script.



