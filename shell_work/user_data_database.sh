#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd
sudo yum install mysql-server -y
sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo yum install git -y 
git clone -b master  https://github.com/KhalidLam/PHP-Blog.git /tmp/shadab
mysql -h localhost -u root -e "create database blog"
cat /tmp/shadab/blog.sql | mysql -h localhost -u root blog
mysql -h localhost -u root -e "CREATE USER 'blog_user'@'%' IDENTIFIED BY 'i9p0o812'"
mysql -h localhost -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'blog_user'@'%' WITH GRANT OPTION"
echo "<html>Shadab Deployed </html>" > /var/www/html/index.php
echo "<html>Shadab Deployed </html>" > /var/www/html/index.html
sudo yum -y install expect
MYSQL_PASS=i9p0o8123
myPid=$!
echo "--> Wait 7s to boot up MySQL on pid ${myPid}"
sleep 7
echo "--> Set root password"
expect -f - <<-EOF
  set timeout 10
  spawn mysql_secure_installation
  expect "Enter current password for root (enter for none):"
  send -- "\r"
  expect "Set root password?"
  send -- "y\r"
  expect "New password:"
  send -- "${MYSQL_PASS}\r"
  expect "Re-enter new password:"
  send -- "${MYSQL_PASS}\r"
  expect "Remove anonymous users?"
  send -- "y\r"
  expect "Disallow root login remotely?"
  send -- "n\r"
  expect "Remove test database and access to it?"
  send -- "y\r"
  expect "Reload privilege tables now?"
  send -- "y\r"
  expect eof
EOF
echo "--> Kill MySQL on pid ${myPid}"
kill -9 ${myPid}

