provider "aws" {
  region ="us-west-2"
}
resource "aws_instance" "terraform" {
   ami  = "ami-db710fa3"
   instance_type = "t2.micro"
   key_name = "jenkins"
   subnet_id = "subnet-0753f74e"
   vpc_security_group_ids = ["sg-630ed51f"]
   associate_public_ip_address = true
   user_data = "${file("install.sh")}"
  tags {
    Name = "terraform"
    Team = "Geeks"
  }
    provisioner "file" {
    source      = "/Users/jayagopal.reddy/Documents/Scripts/terraform/ansible.yml"
    destination = "/home/ubuntu/ansible.yml"
  
    connection {
      user     = "ubuntu"
      private_key  = "${file("/Users/jayagopal.reddy/Documents/Scripts/terraform/jenkins.pem")}"
      agent = "false"
      timeout = "3m"
    }
  }
  
    provisioner "remote-exec" {
    inline = "ansible-playbook /home/ansible/ansible.yml"
    connection {
      user     = "ubuntu"
      private_key  = "${file("/Users/jayagopal.reddy/Documents/Scripts/terraform/jenkins.pem")}"
      agent = "false"
      timeout = "3m"
    }
  }
}
