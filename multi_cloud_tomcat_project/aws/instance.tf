# Key_pair for aws
resource "aws_key_pair" "multikey" {
  key_name = "multikey"
  public_key = file(var.PUB_KEY)
}

#aws instance
resource "aws_instance" "tomcat" {
  ami = var.AWS_AMIS["ubuntu"]
  instance_type = "t3.medium"
  subnet_id = aws_subnet.app1.id
  key_name = aws_key_pair.multikey.key_name
  vpc_security_group_ids = [aws_security_group.petclinic-sg.id]
  tags = {
    name = "tomcat"
  }

    # Delay execution until instance is ready
  provisioner "local-exec" {
    command = "sleep 130"  # Wait for 30 seconds before starting the next provisioner
  }

  #Add a provisioner
    provisioner "file" {
    source      = "shell_scripts/installation.sh"           # Local path to installation.sh
    destination = "/home/ubuntu/installation.sh"             # Remote path where it will be saved
    }

    # Provisioner to upload launch_scripts.sh
    provisioner "file" {
    source      = "shell_scripts/launch_scripts.sh"         # Local path to launch_scripts.sh
    destination = "/home/ubuntu/launch_scripts.sh"           # Remote path where it will be saved
    }

    # Execute the scripts with remote-exec provisioner
    provisioner "remote-exec" {
    inline = [
        "chmod +x /home/ubuntu/installation.sh",               # Make installation.sh executable
        "chmod +x /home/ubuntu/launch_scripts.sh",             # Make launch_scripts.sh executable
        "sudo /home/ubuntu/installation.sh",                   # Execute installation.sh with sudo
        "sudo /home/ubuntu/launch_scripts.sh ${var.REPO_URL}"  # Execute launch_scripts.sh with REPO_URL argument
    ]
    }
    connection {
        type        = "ssh"
        user        = var.USER
        private_key = file(var.PRIV_KEY)
        host        = self.public_ip
        }

}


#CREATING A VOLUME FOR THE INSTANCE TO PROVIDE EXTRA SPACE
#EBS volume
resource "aws_ebs_volume" "tomcat-volume" {
 availability_zone = var.AWS_ZONES["zone1"]
 size = 3
 tags = {
   Name = "tomcat-volume"
 }
}

#Attach volume to instance
resource "aws_volume_attachment" "tomcat-vol-at" {
  device_name = "/dev/xvdh"
  volume_id = aws_ebs_volume.tomcat-volume.id
  instance_id = aws_instance.tomcat.id
}


#Caputure some outputs
output "public_ip" {
  value = aws_instance.tomcat.public_ip
}
