# NAT Configuration Task

[![LinkedIn](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/vijay-v-0889a1280/)

## Introduction

Welcome to my repository! 👋 This project focuses on implementing a NAT configuration using Linux namespaces, bridges, and iptables. It features a network topology consisting of a Private LAN (192.168.10.0/24) with a client node, a Router acting as a NAT gateway with an external public IP, and a simulated internet network. The goal is to facilitate communication between the client node and the internet while effectively utilizing NAT for address translation.

## 🚀 About Me

I am Vijay V (231EE163) 👋, passionate about **systems**, particularly in **cloud** and **networking**. I'm eager to learn and collaborate with like-minded individuals to explore new technologies in these fields.

## Screenshots
Architecture of the system
![image](./Network_topology.png)





### Implementation Steps

1. **Network Namespaces**: Created network namespaces for both the client and the router.
2. **Bridge Setup**: Configured a bridge interface to connect the namespaces.
3. **IP Configuration**: Assigned IP addresses to each namespace and the bridge interface.
4. **NAT Configuration**: Enabled IP forwarding and set up iptables for NAT functionality.
5. **Connectivity Testing**: Conducted connectivity tests from the client namespace to an external network using ping and curl commands, demonstrating the NAT setup's effectiveness.

### Connectivity Test

The connectivity can be tested using ping and curl commands from the client namespace, successfully demonstrating that the client node (`green` or `red`) can access an external network, simulating internet access via the NAT gateway. 

### Lessons Learned

Throughout this project, I gained valuable experience in understanding the core components of networking and NAT, working with Linux namespaces and bridges for network isolation, and troubleshooting connectivity issues related to NAT and iptables. 

### Documentation Resources

For additional reference, consider exploring the following resources: Linux Network Namespaces, Iptables Tutorial, and Network Address Translation. 

Feel free to explore the repository to gain a deeper understanding of the architecture and implementation details!
