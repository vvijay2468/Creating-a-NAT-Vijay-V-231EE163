sudo ip netns add green
sudo ip netns add red
sudo ip link add bro0 type bridge
sudo ip link set bro0 up

sudo ip addr add 192.168.0.1/16 dev bro0



sudo ip link add veth_green_ns type veth peer name veth_green_br
sudo ip link add veth_red_ns type veth peer name veth_red_br
sudo ip link set dev veth_green_ns netns green
sudo ip link set dev veth_red_ns netns red
ip link set dev veth_green_br master bro0
ip link set dev veth_red_br master bro0
ip link set lo up
sudo ip netns exec green ip link set veth_green_ns up
ip netns exec red ip link set veth_red_ns up
ip link set veth_green_br up
ip link set veth_red_br up
sudo ip netns exec green bash
ip link set lo up

sudo ip addr add 192.168.0.2/16 dev veth_green_ns
ip addr
exit
ip netns exec red bash
sudo ip link set lo up
sudo ip addr add 192.168.0.3/16 dev veth_red_ns

ip netns exec green bash
ip route add default via 192.168.0.1
exit
ip netns exec red bash
ip route add default via 192.168.0.1
exit

iptables -t nat -A POSTROUTING -s 192.168.0.0/16 -j MASQUERADE

sudo ip netns exec green bash
ping 8.8.8.8
exit
ip netns exec red bash
ping 8.8.8.8
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -s 192.168.0.0/16 -o eth0 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i bro0 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o bro0 -m state --state ESTABLISHED,RELATED -j ACCEPT

python3 -m http.server 80
curl http://192.168.0.1

iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.10.2:80
iptables -A FORWARD -p tcp -d 192.168.10.2 --dport 80 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
ip netns exec green ip addr add 192.168.10.2/24 dev veth_green_ns
iptables -t nat -A PREROUTING -i bro0 -p tcp --dport 80 -j DNAT --to-destination 192.168.0.2:80
iptables -A FORWARD -p tcp -d 192.168.0.2 --dport 80 -j ACCEPT

iptables -A FORWARD -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -p tcp --dport 443 -j ACCEPT

iptables -A FORWARD -p tcp -j DROP


