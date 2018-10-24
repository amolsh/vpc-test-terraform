
resource "aws_security_group" "pet_elbs" {
    name = "pet-elbs"
    vpc_id = "${aws_vpc.pet_vpc.id}"
    description = "Security group for ELBs"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "pet_elb"
        owner = "shendea"
        environment = "test"
    }
}

/**
  * Security group for each instances
  */
resource "aws_security_group" "pet_pub_instances" {
    name = "pet-pub-instances"
    vpc_id = "${aws_vpc.pet_vpc.id}"
    description = "Security group for instances"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "sg_pet"
        owner = "shendea"
        environment = "test"
    }
}


resource "aws_security_group" "pet_priv_instances" {
  name        = "sg_priv"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.pet_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "pet-pet_priv_instances"
    owner = "shendea"
    environment = "test"
  }
}
