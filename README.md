popandping
==========

This is a simple/dirty bash script to:
- Pull the network UUID and network namespace for each netowrk 
- Pop an instance on each network
- Grab the IP, 
- Attempt to SSH into the instance and ping google

Before using, change line 4 "IMAGE", add the image UUID you want. 
"IMAGE=<DEFINE_IMAGE>"
