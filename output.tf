

output "elb_sg_id" {
    value = "${aws_security_group.pet_elbs.id}"
}

output "sg_instances_id" {
    value = "${aws_security_group.pet_pub_instances.id}"
}

output "elb_dns_name" {
    value = "${aws_alb.pet_alb.dns_name}"
}

output "pub_subnet_ids" {
    value = "${join(",", aws_subnet.pub_subnet.*.id)}"
}

output "priv_subnet_ids" {
    value = "${join(",", aws_subnet.priv_subnet.*.id)}"
}
