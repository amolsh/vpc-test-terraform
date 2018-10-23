#### For public subnet

resource "aws_launch_configuration" "pet_launchconfiguration" {
    name = "pet"
    instance_type = "${var.instance_type}"
    image_id = "${var.image_id}"
    user_data = "${template_file.autoscaling_user_data.rendered}"
    key_name = "${var.ec2_key_name}"
    security_groups = ["${aws_security_group.pet_pub_instances.id}"]
    associate_public_ip_address = true

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "pet_asg" {
    name = "pet"
    max_size = 4
    min_size = 1
    desired_capacity = "${var.desired_capacity_on_demand}"
    health_check_grace_period = 300
    health_check_type = "EC2"
    force_delete = true
    launch_configuration = "${aws_launch_configuration.pet_launchconfiguration.name}"
    vpc_zone_identifier = ["${aws_subnet.pub_subnet.*.id}"]

    tag {
        key = "Name"
        value = "pet"
        propagate_at_launch = true
    }

    tag {
        key = "ownwer"
        value = "shendea"
        propagate_at_launch = true
    }

    tag {
        key = "environment"
        value = "test"
        propagate_at_launch = true
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "template_file" "autoscaling_user_data" {
    template = "${file("autoscaling_user_data_pub.tpl")}"
    vars {}

    lifecycle {
        create_before_destroy = true
    }
}

#### For private subnet

resource "aws_launch_configuration" "pet_launchconfiguration_priv" {
    name = "pet-lc-priv"
    instance_type = "${var.instance_type}"
    image_id = "${var.image_id}"
    user_data = "${template_file.autoscaling_user_data_priv.rendered}"
    key_name = "${var.ec2_key_name}"
    security_groups = ["${aws_security_group.pet_priv_instances.id}"]
    associate_public_ip_address = true

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "pet_asg_priv" {
    name = "pet-asg-priv"
    max_size = 4
    min_size = 1
    desired_capacity = "${var.desired_capacity_on_demand}"
    health_check_grace_period = 300
    health_check_type = "EC2"
    force_delete = true
    launch_configuration = "${aws_launch_configuration.pet_launchconfiguration_priv.name}"
    vpc_zone_identifier = ["${aws_subnet.priv_subnet.*.id}"]

    tag {
        key = "Name"
        value = "pet"
        propagate_at_launch = true
    }

    tag {
        key = "ownwer"
        value = "shendea"
        propagate_at_launch = true
    }

    tag {
        key = "environment"
        value = "test"
        propagate_at_launch = true
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "template_file" "autoscaling_user_data_priv" {
    template = "${file("autoscaling_user_data_priv.tpl")}"
    vars {}

    lifecycle {
        create_before_destroy = true
    }
}
