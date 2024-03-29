
data "aws_ami" "webservers_ami" {
	owners = ["137112412989"]
	filter {
		name = "name"
		values = ["amzn2-ami-hvm-*"]
	}
	most_recent = true
}

resource "aws_instance" "webservers" {
	ami = "${data.aws_ami.webservers_ami.id}"
	instance_type = "${var.instance_type}"
	security_groups = ["${aws_security_group.webservers.id}"]
	subnet_id = "${element(aws_subnet.public.*.id,count.index)}"
	user_data = "${file("install_httpd.sh")}"
	
    tags = {
      Name = "Test-Instance"
	    Owner = "${var.tagOwner}"
	    Environment	= "Test-CI"
  }
}
