{
/ip firewall filter remove [ find comment="SSH,Winbox_l2tp-spb_A_main"]
/ip firewall filter add chain=input protocol=tcp dst-port=22,8291 in-interface=l2tp-spb_A_main action=accept place-before=3 comment="SSH,Winbox_l2tp-spb_A_main"
}
