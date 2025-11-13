#!/bin/bash
# System monitoring script for Debian

echo "=== System Information ==="
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"
echo "Kernel: $(uname -r)"
echo "Distribution: $(lsb_release -d | cut -f2)"

echo -e "\n=== CPU Usage ==="
top -bn1 | grep "Cpu(s)" | awk '{print $2 $3}' | sed 's/%us,/% user,/' | sed 's/%sy/% system/'

echo -e "\n=== Memory Usage ==="
free -h

echo -e "\n=== Disk Usage ==="
df -h | grep -E '^/dev/'

echo -e "\n=== Network Interfaces ==="
ip addr show | grep -E '^[0-9]+:|inet '

echo -e "\n=== Active Services ==="
systemctl list-units --type=service --state=active | head -10

echo -e "\n=== Recent Failed Logins ==="
journalctl -u ssh --since "1 hour ago" | grep "Failed password" | tail -5
