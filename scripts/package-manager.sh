#!/bin/bash
# Package management utilities for Debian

show_help() {
    echo "Usage: $0 [OPTION]"
    echo "Debian package management utilities"
    echo ""
    echo "Options:"
    echo "  update      Update package lists"
    echo "  upgrade     Upgrade all packages"
    echo "  cleanup     Remove unnecessary packages"
    echo "  security    Install security updates only"
    echo "  info        Show system package information"
    echo "  help        Show this help message"
}

update_packages() {
    echo "Updating package lists..."
    sudo apt update
}

upgrade_packages() {
    echo "Upgrading packages..."
    sudo apt upgrade -y
}

cleanup_system() {
    echo "Cleaning up unnecessary packages..."
    sudo apt autoremove -y
    sudo apt autoclean
}

security_updates() {
    echo "Installing security updates..."
    sudo apt list --upgradable | grep -i security
    sudo unattended-upgrade
}

show_info() {
    echo "=== Package Information ==="
    echo "Total packages: $(dpkg -l | wc -l)"
    echo "Upgradable packages: $(apt list --upgradable 2>/dev/null | wc -l)"
    echo "Last update: $(stat -c %y /var/cache/apt/pkgcache.bin 2>/dev/null || echo 'Unknown')"
}

case "$1" in
    update)
        update_packages
        ;;
    upgrade)
        upgrade_packages
        ;;
    cleanup)
        cleanup_system
        ;;
    security)
        security_updates
        ;;
    info)
        show_info
        ;;
    help|*)
        show_help
        ;;
esac
