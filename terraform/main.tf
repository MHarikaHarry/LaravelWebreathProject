provider "aws" {
  aws-region: ${{ secrets.AWS_DEFAULT_REGION }}
}
- name: Set up AWS credentials
  uses: aws-actions/configure-aws-credentials@v1
  with:
       aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
       aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
       

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
