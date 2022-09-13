provider "aws" {
  region     = "eu-west-1"
  access_key = "AKIASIUCGA6KTB6SPSNN"
  secret_key = "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"
}




# Deployment Variables 

 # 1. Create vpc
 resource "aws_vpc" "dev10-vpc" {
   cidr_block = "10.0.0.0/16"
   tags = {
     Name = "dev10-vpc"
   }
 }

# # 2. Create Internet Gateway
resource "aws_internet_gateway" "dev10-gw" {
   vpc_id = aws_vpc.dev10-vpc.id
 }

# # 3. Create Custom Route Table

 resource "aws_route_table" "dev10-route-table" {
   vpc_id = aws_vpc.dev10-vpc.id

   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.dev10-gw.id
   }

   route {
     ipv6_cidr_block = "::/0"
     gateway_id      = aws_internet_gateway.dev10-gw.id
   }

   tags = {
     Name = "dev10-gateway"
   }
 }

# # 4. Create a Subnet 

resource "aws_subnet" "dev10-subnet-1" {
   vpc_id            = aws_vpc.dev10-vpc.id
   cidr_block        = "10.0.1.0/24"
   availability_zone = "eu-west-1a"

   tags = {
     Name = "dev10-subnet"
   }
 }

# # 5. Associate subnet with Route Table
 resource "aws_route_table_association" "a" {
   subnet_id      = aws_subnet.dev10-subnet-1.id
   route_table_id = aws_route_table.dev10-route-table.id
 }


# # 6. Create Security Group to allow port 80,443
 resource "aws_security_group" "dev10-allow_web" {
   name        = "allow_dev10-web_traffic"
   description = "Allow dev10 Web inbound traffic"
   vpc_id      = aws_vpc.dev10-vpc.id
   depends_on = [aws_network_interface.dev10-dev-server-nic]
   ingress {
     description = "HTTPS"
     from_port   = 443
     to_port     = 443
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
     description = "HTTP"
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0" ]
   }

    ingress {
     description = "HTTP"
     from_port   = 3012
     to_port     = 3012
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   } 
  
  ingress {
     description = "HTTP"
     from_port   = 11211
     to_port     = 11211
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   } 

   ingress {
     description = "SSH"
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     #cidr_blocks =  [ aws_vpc.dev10-vpc.cidr_block]
       cidr_blocks = ["0.0.0.0/0"]
   }

  

   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
     Name = "dev10-web-sg"
   }
 }


resource "aws_security_group" "dev10-allow_dev" {
   name        = "allow_dev10-dev_traffic"
   description = "Allow dev10 Web inbound traffic"
   vpc_id      = aws_vpc.dev10-vpc.id

   ingress {
     description = "HTTP"
     from_port   = 8080
     to_port     = 8080
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

    ingress {
     description = "HTTP"
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   } 


   ingress {
     description = "HTTP"
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }


   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
     Name = "dev10-dev-sg"
   }
 }
resource "aws_security_group" "dev10-allow_db" {
   name        = "allow_dev10-db_traffic"
   description = "Allow dev10 Web & dev inbound traffic"
   vpc_id      = aws_vpc.dev10-vpc.id

    ingress {
     description = "HTTP"
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   } 


   ingress {
     description = "HTTP"
     from_port   = 3306
     to_port     = 3306
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }


   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
     Name = "dev10-db-sg"
   }
 }

# # 7. Create a network interface with an ip in the subnet that was created in step 4

 resource "aws_network_interface" "dev10-web-server-nic" {
   subnet_id       = aws_subnet.dev10-subnet-1.id
   private_ips     = ["10.0.1.50"]
   security_groups = [aws_security_group.dev10-allow_web.id]

 }

resource "aws_network_interface" "dev10-dev-server-nic" {
   subnet_id       = aws_subnet.dev10-subnet-1.id
   private_ips     = ["10.0.1.51"]
   security_groups = [aws_security_group.dev10-allow_dev.id]

 }
 resource "aws_network_interface" "dev10-db-server-nic" {
   subnet_id       = aws_subnet.dev10-subnet-1.id
   private_ips     = ["10.0.1.52"]
   security_groups = [aws_security_group.dev10-allow_db.id]

 }


# # 8. Assign an elastic IP to the network interface created in step 7

 resource "aws_eip" "one" {
   vpc                       = true
   network_interface         = aws_network_interface.dev10-web-server-nic.id
   associate_with_private_ip = "10.0.1.50"
   depends_on                = [aws_internet_gateway.dev10-gw]
 }


 resource "aws_eip" "two" {
   vpc                       = true
   network_interface         = aws_network_interface.dev10-dev-server-nic.id
   associate_with_private_ip = "10.0.1.51"
   depends_on                = [aws_internet_gateway.dev10-gw]
 }
 
resource "aws_eip" "three" {
   vpc                       = true
   network_interface         = aws_network_interface.dev10-db-server-nic.id
   associate_with_private_ip = "10.0.1.52"
   depends_on                = [aws_internet_gateway.dev10-gw]
 }
 

# # 9. Create Ubuntu server and install/enable apache2

resource "aws_instance" "dev10-web-server-instance" {
   ami               = "ami-0bf84c42e04519c85"
   instance_type     = "t2.micro"
   availability_zone = "eu-west-1a"
   key_name          = "dev-1.0"
   network_interface {
     device_index         = 0
     network_interface_id = aws_network_interface.dev10-web-server-nic.id
   }

   user_data = <<-EOF
                 #!/bin/bash
                 sudo yum update -y
                 sudo yum install -y httpd
                 sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2 -y
                 sudo systemctl enable httpd
                 sudo usermod -a -G apache ec2-user
                 sudo chown -R ec2-user:apache /var/www
                 sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
                 find /var/www -type f -exec sudo chmod 0664 {} \;
                 sudo systemctl start httpd 
                 EOF
   tags = {
     Name = "dev10-web-server"
   }
 }


resource "aws_instance" "dev10-dev-server-instance" {
   ami               = "ami-0bf84c42e04519c85"
   instance_type     = "t3.small"
   availability_zone = "eu-west-1a"
   key_name          = "dev-1.0"
   network_interface {
     device_index         = 0
     network_interface_id = aws_network_interface.dev10-dev-server-nic.id
   }

  root_block_device {
    volume_size = 20 # in GB <<----- I increased this!
    volume_type = "gp2"
  }
     
   user_data = <<EOF
                 #!/bin/bash
                 master_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEhBx2KDqY+woh6lyfbjsLfVuCiUZGE4uFxBLozzuNhicGK56QSeL9hZqXNZGGsJe020ahB+1l4E1hOvgxCvAT2oy8Xpn/PNXOc1Ipk/xLWD+o8Or/N7pjnx7pO/rB0R0We3oo+X63ipMz4BRosXmqlDCxtsgsDalOM1TpnZHfiz5crTW4PXgCNWX61/0+bP+E9pzHlBqVFdfAxPkgGawCFZU0fJxlecHSCcgCD61b7vWHAZVVtC4U/SMRTR7TSQp1rDW0cXCwmAqBNxMvY+2WnHfAqtkQJ/qzPOcTu/JmQDFfUpUBDLRpKqMTZqt7JYtqx3Nip3Cyn1KoNB2Vc3+ccKxMZubcqxfrFKjbiON6K6AJuN0yTK0IRGS4ZqosXLuO4cIACXB4Xwmef0wmjtGTq05RjjdQxi66bszX3kJzUvR3P2COybQHH57kIUMSyKvbDUOcIYw5fOUglgjWDNEcJhSJ3CRVl1ALEF3JbO88E/UTBLjF5ZOog03PBfWuY6E= admin@DESKTOP-2QG1OSE"
                 sudo yum update -y
                 sudo yum install git-all -y
                 sudo wget -O /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/redhat-stable/jenkins.repo
                 sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
                 sudo amazon-linux-extras install epel -y  
                 sudo amazon-linux-extras install java-openjdk11 -y
                 sudo yum install jenkins -y
                 sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2 -y
                 sudo yum install -y php-memcached
                 sudo yum install php-pgsql -y 
                 sudo echo "
                             <VirtualHost *:80>
                              DocumentRoot "/var/www/html"
                             </VirtualHost>
                           " >>/etc/httpd/conf/httpd.conf
                 sudo systemctl start httpd  
                 list_of_users="ajaz|ajaz.rahman@abcdata.org,zulqurnain|zulqurnain.ali@abcdata.org,humaira|"
                 
                 git_portal_repo="https://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@github.com/abcdataorg/sarmaaya-web.git"
                 git_api_repo="https://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@github.com/abcdataorg/sarmaaya-api.git"
                 
                 for ulist in `echo $list_of_users | tr ',' '\n'`; do
                      u=`echo $ulist | cut -d '|' -f1`
                      m=`echo $ulist | cut -d '|' -f2`
                      sudo useradd $u
                      sudo -u $u mkdir /home/$u/.ssh && sudo -u $u chmod 700 /home/$u/.ssh && sudo -u $u touch /home/$u/.ssh/authorized_keys && sudo -u $u chmod 600 /home/$u/.ssh/authorized_keys
                      sudo -u $u echo $master_key >> /home/$u/.ssh/authorized_keys
                      sudo mkdir /var/www/html/$u
                      sudo chown -R $u:apache /var/www/html/$u
                      sudo -u $u cd /var/www/html/$u && git init 
                      sudo -u $u git config --global user.email $m
                      sudo -u $u git config --global user.name $u
                      sudo -u $u git config --global init.defaultBranch $u
                      sudo -u $u git clone -b $u $git_portal_repo /var/www/html/$u/sp
                      sudo -u $u git clone -b $u $git_api_repo /var/www/html/$u/api
                      sudo chmod 2775 /var/www/html/$u && find /var/www/html/$u -type d -exec sudo chmod 2775 {} \;
                      
                      
                      
                 done
                 sudo yum install httpd 
EOF

   tags = {
     Name = "dev10-dev-server"
   }
 }
resource "aws_instance" "dev10-db-server-instance" {
   ami               = "ami-09d5dd12541e69077"
   instance_type     = "t3.small"
   availability_zone = "eu-west-1a"
   key_name          = "dev-1.0"
   network_interface {
     device_index         = 0
     network_interface_id = aws_network_interface.dev10-db-server-nic.id
   }

  root_block_device {
    volume_size = 20 # in GB <<----- I increased this!
    volume_type = "gp2"
  }
     
   tags = {
     Name = "dev10-db-server"
   }
 }



output "web_server_ip" {
   value = aws_instance.dev10-dev-server-instance.public_ip 
}