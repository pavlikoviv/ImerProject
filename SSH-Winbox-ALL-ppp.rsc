{
/ip firewall filter remove [ find comment="SSH,Winbox_ALL_PPP"]
/ip firewall filter add chain=input protocol=tcp dst-port=22,8291 in-interface=all-ppp action=accept place-before=3 comment="SSH,Winbox_ALL_PPP"
}
