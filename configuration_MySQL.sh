# https://dev.mysql.com/doc/mysql-secure-deployment-guide/5.7/en/secure-deployment-configure-authentication.html

CREATE USER 'valerie'@'localhost' IDENTIFIED WITH auth_socket;

plugin-load-add=auth_socket.so
auth_socket=FORCE_PLUS_PERMANENT

systemctl restart mysqld
cd /usr/local/mysql
bin/mysqladmin -u root -p version

SELECT PLUGIN_NAME, PLUGIN_STATUS
       FROM INFORMATION_SCHEMA.PLUGINS
       WHERE PLUGIN_NAME LIKE '%socket%';
       
ALTER USER 'root'@'localhost' IDENTIFIED WITH auth_socket;
SELECT user, plugin FROM mysql.user WHERE user IN ('root')\G

cd /usr/local/mysql
bin/mysql -u root
