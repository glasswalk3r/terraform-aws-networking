variable "environment" {
  default = "test"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "VPC-NAT-Gateway-Instance"
}

variable "nat_cmd" {
  description = "The user data to configure NAT with iptables"
  default     = <<EOT
echo 1 > /proc/sys/net/ipv4/ip_forward && \
/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE && \
/sbin/iptables -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT && \
/sbin/iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT && \
sed -i -e 's/^\(net.ipv4.ip_forward\)[[:space:]]\?=[[:space:]]\?0/\1 = 1/' /etc/sysctl.conf && \
sed -i -e 's/^\(IPTABLES_MODULES_UNLOAD\)=".*"/\1="yes"/' /etc/sysconfig/iptables-config /etc/sysconfig/iptables-config && \
sed -i -e 's/^\(IPTABLES_SAVE_ON_[[:alpha:]]*\)=".*"/\1="yes"/' /etc/sysconfig/iptables-config
EOT
}
