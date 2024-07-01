{
/ip firewall filter remove [ find comment="Drop_user_pppoe"]
/ip firewall filter add action=drop chain=input comment=Drop_user_pppoe dst-port=22,8291 in-interface=user_pppoe protocol=tcp place-before=[find comment="SSH,Winbox_ALL_PPP"]
}
