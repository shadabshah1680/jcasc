#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2 -y
sudo yum install httpd -y 
sudo systemctl enable httpd
sudo systemctl start httpd php-fpm
sudo usermod -a -G apache ec2-user
sudo yum install git -y
rm -rf /var/www/html
git clone -b main https://github.com/shadabshah1680/blog.git /var/www/html
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
sed -i 's/localhost/DB-ASG-1-8393c6757ecedd7b.elb.us-east-2.amazonaws.com/g'  /var/www/html/assest/db.php