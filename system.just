[macos]
firewall-on:
    #!/bin/sh
    fw=/usr/libexec/ApplicationFirewall/socketfilterfw
    sudo "$fw" --setglobalstate on
    sudo "$fw" --setallowsigned on
    sudo "$fw" --setallowsignedapp on
    sudo "$fw" --setstealthmode on

[macos]
firewall-off:
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off

# no linux stack for firewall because meh

# alllll the hostname declarations! (macos especially is finnicky
# about this when duplicate hostnames exist, so we have a recipe for it)
[macos]
hostname name:
    sudo scutil --set ComputerName {{ name }}
    sudo scutil --set HostName {{ name }}
    sudo scutil --set LocalHostName {{ name }}

[linux]
hostname name:
    sudo hostnamectl set-hostname {{ name }}
