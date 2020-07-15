#          _                        __ _       
#         | |                      / _(_)      
#  ___ ___| |__     ___ ___  _ __ | |_ _  __ _ 
# / __/ __| '_ \   / __/ _ \| '_ \|  _| |/ _` |
# \__ \__ \ | | | | (_| (_) | | | | | | | (_| |
# |___/___/_| |_|  \___\___/|_| |_|_| |_|\__, |
                                        __/ |
                                       |___/ 

#In 2006, the SSH protocol was updated from version 1 to version 2. 
#It was a significant upgrade. 
#There were so many changes and improvements, 
#especially around encryption and security, 
#that version 2 is not backward compatible with version 1. 
#To prevent connections from version 1 clients, 
#you can stipulate that your computer will only accept connections from version 2 clients.

protocol 2

#Avoid port 22

#Port 22 is the standard port for SSH connections. 
#If you use a different port, it adds a little bit of security through obscurity to your system. 
#Security through obscurity is never considered a true security measure, and I have railed against it in other articles. 
#In fact, some of the smarter attack bots probe all open ports and determine which service they are carrying, 
#rather than relying on a simple look-up list of ports and assuming they provide the usual services. 
#But using a non-standard port can help with lowering the noise and bad traffic on port 22.

port 897

#Add a TCP Wrappers
#We need intsall tcp wrapper for gain Security inour system

sudo yum install tcp-wrappers

echo "ALL : ALL" >> /etc/host.deny

echo "sshd : 192.168.0.21" >> /etc/host.allow
# if we need more services we can add them here
# echo "tcp : 192.168.0.21" >> /etc/host.allow

# The default settings for SSH accept connection requests without passwords.  
# We can change that very easily, and ensure all connections are authenticated.

PermitEmptyPasswords no

# Disable X11 Forwarding
X11Forwarding no

# set an idle timeout value
ClientAliveInterval 300

# Set limit passwords attemps
MaxAuthTries 3

# Disable Root Logins
PermitRootLogin prohibit-password

# Restart service
