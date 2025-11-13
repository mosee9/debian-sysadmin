# Debian Security Hardening Guide

## SSH Hardening

### 1. Configure SSH
Edit `/etc/ssh/sshd_config`:

```bash
# Disable root login
PermitRootLogin no

# Use key-based authentication
PasswordAuthentication no
PubkeyAuthentication yes

# Change default port
Port 2222

# Limit users
AllowUsers username

# Disable empty passwords
PermitEmptyPasswords no

# Set login grace time
LoginGraceTime 60
```

### 2. Restart SSH service
```bash
sudo systemctl restart sshd
```

## Firewall Configuration

### Using UFW (Uncomplicated Firewall)

```bash
# Enable UFW
sudo ufw enable

# Default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH (adjust port if changed)
sudo ufw allow 2222/tcp

# Allow HTTP/HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Check status
sudo ufw status verbose
```

## Fail2ban Setup

### 1. Install fail2ban
```bash
sudo apt update
sudo apt install fail2ban
```

### 2. Configure
Copy the jail.local file from configs/ to `/etc/fail2ban/jail.local`

### 3. Start service
```bash
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

## System Updates

### 1. Enable automatic security updates
```bash
sudo apt install unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades
```

### 2. Configure automatic updates
Edit `/etc/apt/apt.conf.d/50unattended-upgrades`

## User Account Security

### 1. Password policies
Install and configure libpam-pwquality:
```bash
sudo apt install libpam-pwquality
```

### 2. Account lockout
Configure pam_tally2 for account lockout after failed attempts.

## File System Security

### 1. Set proper permissions
```bash
# Secure /tmp
sudo chmod 1777 /tmp

# Secure home directories
sudo chmod 750 /home/*
```

### 2. Disable unused filesystems
Add to `/etc/modprobe.d/blacklist-rare-filesystems.conf`:
```
install cramfs /bin/true
install freevxfs /bin/true
install jffs2 /bin/true
install hfs /bin/true
install hfsplus /bin/true
install squashfs /bin/true
install udf /bin/true
```
