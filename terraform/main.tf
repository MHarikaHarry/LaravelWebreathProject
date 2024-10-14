provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "laravel_instance" {
  ami           = "ami-0866a3c8686eaeeba"  # Ubuntu AMI ID
  instance_type = "t2.micro"
  key_name      = "webreathkeypair.pem"  #  create a key pair 

  tags = {
    Name = "LaravelAppServer"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx php php-fpm",
      "sudo systemctl start nginx"
    ]
  }
}

output "instance_ip" {
  value = aws_instance.laravel_instance.public_ip
}
