resource "aws_alb_target_group" "pet-alb-tg" {
    depends_on = ["aws_alb.pet_alb"]
    name     = "pet-alb-tg"
    port     = 8080
    protocol = "HTTP"
    vpc_id   = "${aws_vpc.pet_vpc.id}"

    health_check {
        matcher = "200,302,303,301,403"
        timeout = 20
        unhealthy_threshold = 5
    }

    stickiness {
        type   = "lb_cookie"
    }

    tags {
          Name = "pet-alb-tg"
          owner = "shendea"
          environment = "test"
    }
}

resource "aws_alb" "pet_alb" {
    name            = "pet-alb"
    subnets         = ["${aws_subnet.pub_subnet.*.id}","${aws_subnet.pub_subnet2.*.id}"]
    security_groups = ["${aws_security_group.pet_elbs.id}"]
    idle_timeout = 400
    tags {
          Name = "pet_alb"
          owner = "shendea"
          environment = "test"
    }
}

resource "aws_alb_listener" "front_end" {
    load_balancer_arn = "${aws_alb.pet_alb.id}"
    port              = "80"
    protocol          = "HTTP"
    default_action {
      target_group_arn = "${aws_alb_target_group.pet-alb-tg.id}"
      type             = "forward"
    }
}
