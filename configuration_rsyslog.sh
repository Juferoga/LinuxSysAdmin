#                    _                                __ _       
#                   | |                              / _(_)      
# _ __ ___ _   _ ___| | ___   __ _    ___ ___  _ __ | |_ _  __ _ 
#| '__/ __| | | / __| |/ _ \ / _` |  / __/ _ \| '_ \|  _| |/ _` |
#| |  \__ \ |_| \__ \ | (_) | (_| | | (_| (_) | | | | | | | (_| |
#|_|  |___/\__, |___/_|\___/ \__, |  \___\___/|_| |_|_| |_|\__, |
#           __/ |             __/ |                         __/ |
#          |___/             |___/                         |___/ 

yum -y install gnutls-utils

certtool --generate-privkey --outfile ca-key.pem

chmod 400 ca-key.pem

certtool --generate-self-signed --load-privkey ca-key.pem --outfile ca.pem

certtool --generate-privkey --outfile node3-key.pem --bits 2048

certtool --generate-request --load-privkey node3-key.pem --outfile node3-request.pem

certtool --generate-certificate --load-request node3-request.pem --outfile node3-cert.pem --load-ca-certificate ca.pem --load-ca-privkey ca-key.pem

rm -f node3-request.pem

mkdir /etc/rsyslog-keys && cd /etc/rsyslog-keys

scp node3-*.pem node3:/etc/rsyslog-keys/

scp ca.pem node3:/etc/rsyslog-keys/

# make gtls driver the default
echo "$DefaultNetstreamDriver gtls" >> /etc/rsyslog.d/logserver.conf
# certificate files
echo "$DefaultNetstreamDriverCAFile /etc/rsyslog-keys/ca.pem" >> /etc/rsyslog.d/logserver.conf
echo "$DefaultNetstreamDriverCertFile /etc/rsyslog-keys/node3-cert.pem" >> /etc/rsyslog.d/logserver.conf
echo "$DefaultNetstreamDriverKeyFile /etc/rsyslog-keys/node3-key.pem" >> /etc/rsyslog.d/logserver.conf
echo "$ModLoad imtcp  # TCP listener" >> /etc/rsyslog.d/logserver.conf
echo "$InputTCPServerStreamDriverMode 1  # run driver in TLS-only mode" >> /etc/rsyslog.d/logserver.conf
echo "$InputTCPServerStreamDriverAuthMode anon" >> /etc/rsyslog.d/logserver.conf
echo "$InputTCPServerRun 6514  # start up listener at port 10514" >> /etc/rsyslog.d/logserver.conf
