provider "aws" {
  region = "us-east-1"  # Change the region as per your requirement
}

# EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with your desired AMI ID
  instance_type = "m5.2xlarge"  # 8 vCPUs and 32GB of RAM

  key_name      = "my-key-pair"  # Replace with your key pair name

  # Block device mapping to specify disk size
  root_block_device {
    volume_size = 50  # Adjust the volume size as needed
  }

  # Network interface
  network_interface {
    device_index          = 0
    network_interface_id  = aws_network_interface.example.id
  }

  # Associate with an Elastic IP
  associate_public_ip_address = true
}

# Network Interface
resource "aws_network_interface" "example" {
  subnet_id   = aws_subnet.example.id
  private_ips = ["10.0.1.50"]  # Static private IP

  # Security groups
  security_groups = [aws_security_group.instance_sg.name]
}

# Elastic IP
resource "aws_eip" "example" {
