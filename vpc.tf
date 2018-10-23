/* Create a VPC */

resource "aws_vpc" "pet_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags {
        Name = "petvpc"
        owner = "shendea"
        environment = "test"
    }
}

resource "aws_subnet" "pub_subnet" {
    count = 1
    vpc_id = "${aws_vpc.pet_vpc.id}"
    cidr_block = "${var.pub_subnet_cidr}"
    map_public_ip_on_launch = true
    availability_zone = "us-west-2a"

    tags {
        Name = "pub-subnet"
        owner = "shendea"
        environment = "test"
    }
}

resource "aws_subnet" "priv_subnet" {
    vpc_id = "${aws_vpc.pet_vpc.id}"
    cidr_block = "${var.priv_subnet_cidr}"
    map_public_ip_on_launch = true
    availability_zone = "us-west-2a"

    tags {
        Name = "priv-subnet"
        owner = "shendea"
        environment = "test"
    }
}

resource "aws_internet_gateway" "pet_gw" {
    vpc_id = "${aws_vpc.pet_vpc.id}"

    tags {
        Name = "pet_gw"
        owner = "shendea"
        environment = "test"
    }
}

resource "aws_route_table" "pub_rt" {
    vpc_id = "${aws_vpc.pet_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.pet_gw.id}"
    }

    tags {
        Name = "pub_rt"
        owner = "shendea"
        environment = "test"
    }
}

resource "aws_route_table_association" "pub_rt_association" {
    #vpc_id = "${aws_vpc.pet_vpc.id}"
    subnet_id = "{aws_subnet.pub_subnet.id}"
    route_table_id = "${aws_route_table.pub_rt.id}"
}

resource "aws_vpc_dhcp_options" "dns_resolver" {
    domain_name_servers = ["AmazonProvidedDNS"]

    tags {
        Name = "pet_dns"
        owner = "shendea"
        environment = "test"
    }
}

resource "aws_vpc_dhcp_options_association" "pet_dhcp_options" {
    vpc_id = "${aws_vpc.pet_vpc.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.dns_resolver.id}"
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${aws_subnet.pub_subnet.id}"
}

resource "aws_route_table" "priv_rt" {
  vpc_id = "${aws_vpc.pet_vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
  }

  tags {
    Name = "priv_rt"
    owner = "shendea"
    environment = "test"
  }
}

resource "aws_route_table_association" "priv_rt_association" {
  subnet_id      = "${aws_subnet.priv_subnet.id}"
  route_table_id = "${aws_route_table.priv_rt.id}"
}
