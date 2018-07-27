# 只用请求构造一个代理服务器
resource "qingcloud_eip" "init" {
  name = "public ip"
  description = "ip-main"
  billing_mode = "traffic"
  bandwidth = "${var.brandwidth}"
  need_icp = 0
}

# 防火墙及规则
# 外网
resource "qingcloud_security_group" "basic" {
  name = "firewall internet"
  description = "internet firewall"
}

// 貌似底层有bug，无法正常识别ICMP，不是大问题
//resource "qingcloud_security_group_rule" "basic-icmp" {
//  security_group_id = "${qingcloud_security_group.basic.id}"
//  protocol = "icmp"
//  priority = 0
//  action = "accept"
//}

resource "qingcloud_security_group_rule" "basic-http-in" {
  security_group_id = "${qingcloud_security_group.basic.id}"
  protocol = "tcp"
  priority = 0
  action = "accept"
  direction = 0
  from_port = 80
  to_port = 80
}

resource "qingcloud_security_group_rule" "basic-https-in" {
  security_group_id = "${qingcloud_security_group.basic.id}"
  protocol = "tcp"
  priority = 0
  action = "accept"
  direction = 0
  from_port = 443
  to_port = 443
}

# shadowsocks
resource "qingcloud_security_group" "ss" {
  name = "firewall for hello world"
  description = "hello world firewall"
}

resource "qingcloud_security_group_rule" "ss-in" {
  security_group_id = "${qingcloud_security_group.ss.id}"
  protocol = "tcp"
  priority = 0
  action = "accept"
  direction = 0
  from_port = 22
  to_port = 22
}

resource "qingcloud_security_group_rule" "ss-in-primary" {
  security_group_id = "${qingcloud_security_group.ss.id}"
  protocol = "tcp"
  priority = 0
  action = "accept"
  direction = 0
  from_port = 12345
  to_port = 12345
}

resource "qingcloud_security_group_rule" "ss-in-guest" {
  security_group_id = "${qingcloud_security_group.ss.id}"
  protocol = "tcp"
  priority = 0
  action = "accept"
  direction = 0
  from_port = 30010
  to_port = 30010
}

# root 公钥
resource "qingcloud_keypair" "root" {
  name = "stormxx"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# 机器
resource "qingcloud_instance" "init" {
  count = 1
  name = "${var.hostname}"
  image_id = "${var.image-id}"
  instance_class = "0"
  managed_vxnet_id = "vxnet-0"
  keypair_ids = [
    "${qingcloud_keypair.root.id}"]
  security_group_id = "${qingcloud_security_group.ss.id}"
  eip_id = "${qingcloud_eip.init.id}"
  cpu = "${var.cpu}"
  memory = "${var.memory}"
}

//# 内网
//
//# 路由器 - 不适合自动化
//resource "qingcloud_vpc" "init" {
//  eip_id = "${qingcloud_eip.init.id}"
//  security_group_id = "${qingcloud_security_group.basic.id}"
//  vpc_network = "192.168.0.0/16"
//}
//
//resource "qingcloud_vxnet" "k8s" {
//  type = "0"
//  vpc_id = "${qingcloud_vpc.init.id}"
//  ip_network = "192.168.10.0/24"
//}

//
//# 主节点
//resource "qingcloud_instance" "k8s" {
//  count = 1
//  name = "k8s-${count.index}"
////  hostname = "k8s-${count.index}"
//  image_id = "coreose"
//  instance_class = "0"
//  managed_vxnet_id = "vxnet-0"
//  keypair_ids = [
//    "${qingcloud_keypair.root.id}"]
//  security_group_id = "${qingcloud_security_group.lan.id}"
//  //  cpu = 2
//  //  memory = 4096
//  cpu = 1
//  memory = 1024
//}
