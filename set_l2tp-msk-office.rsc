{
#get user
:global l2tpUser [/interface l2tp-client get [find name =l2tp-HQ_main] user]
#get pass
:global l2tpUserPass [/interface l2tp-client get [find name =l2tp-HQ_main] password]
#get ip local and cut mask
:global ipLocalStore [:pick [/ip address  get [find interface="bridge"] address] 0 [:find [/ip address  get [find interface="bridge"] address] "/"]]
delay 2

#set l2tp-msk-office
/interface l2tp-client remove [find name =l2tp-msk-office]
/interface l2tp-client add connect-to=msc-uvm.impsa.TECH allow=mschap1,mschap2 disabled=no ipsec-secret="imPra765T\$" name=l2tp-msk-office use-ipsec=no password=$l2tpUserPass user=$l2tpUser
:global HQRoute;
:set HQRoute [ip route find dst-address=172.16.3.0/24];
:if ($HQRoute = "") do={
/ip route add distance=1 dst-address=172.16.3.0/24 gateway=l2tp-msk-office pref-src=$ipLocalStore}
delay 2
}
