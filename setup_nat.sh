sudo ip netns add red
sudo ip link add bro0 type bridge
sudo ip link set bro0 up
sudo ip addr add 192.168.10.1/16 dev bro0
sudo ip netns list
sudo ip link list
sudo ip add
sudo ip link add veth_green_ns type veth peer name veth_green_br
sudo ip link add veth_red_ns type veth peer name veth_red_br
sudo ip link list
sudo ip link set dev veth_green_ns netns green
sudo ip link set dev veth_red_ns netns red
sudo ip link set dev veth_green_br master bro0
sudo ip link set dev veth_red_br master bro0
sudo ip link set lo up
sudo ip netns exec green ip link set veth_green_ns up
sudo ip netns exec red ip link set veth_red_ns up
sudo ip link set veth_green_br up
sudo ip link set veth_red_br up
sudo ip link list
sudo ip netns exec green bash
sudo ip link set lo up
sudo ip addr add 192.168.10.2/16 dev veth_green_ns
exit
sudo ip netns exec red bash
sudo ip link set lo up
sudo ip addr add 192.168.10.3/16 dev veth_red_ns
sudo ip add
ping 192.168.10.2
exit
ping 192.168.10.2
sudo ip netns exec green bash
route
ip route add default via 192.168.10.1
route
exit
sudo ip netns exec red bash
ip route add default via 192.168.10.1
exit
sudo iptables -t nat -A POSTROUTING -s 192.168.0.0/16 -j MASQUERADE
sudo ip netns exec green bash
ping 8.8.8.8
exit
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -s 192.168.10.0/24 -o veth_red_br -j MASQUERADE
sudo iptables -t nat -A PREROUTING -i veth_red_br -p tcp --dport 8080 -j DNAT --to-destination 192.168.10.2:8080


# Allow HTTP (port 80) and HTTPS (port 443) from the green namespace
sudo iptables -A FORWARD -s 192.168.10.0/24 -p tcp --dport 80 -j ACCEPT
sudo iptables -A FORWARD -s 192.168.10.0/24 -p tcp --dport 443 -j ACCEPT

# Block other traffic
sudo iptables -A FORWARD -s 192.168.10.0/24 -j DROP

