{
    #-------------------------------------------------------------------------------
    #
    # The purpose of this script is to create two l2tp chanel (to Mira)
    # 
    #
    #-------------------------------------------------------------------------------

/system backup save name=disconnect password="secret"

#Create route l2tp_tun_mira
#get ip local and cut mask
:global ipLocalStore [:pick [/ip address  get [find interface="bridge"] address] 0 [:find [/ip address  get [find interface="bridge"] address] "/"]]

#get user
:global l2tpUser [/interface l2tp-client get [find name =l2tp-HQ_sub] user]

#get pass
:global l2tpUserPass [/interface l2tp-client get [find name =l2tp-HQ_sub] password]
:global RuleStatus;
:set RuleStatus [ip route find dst-address=172.16.2.0/24];
:if ($RuleStatus = "") do={
/ip route add distance=1 dst-address=172.16.2.0/24 gateway=l2tp-spb_A_main pref-src=$ipLocalStore
}
#add main route to HQ
#delete default route
#delete depricated static route

:global HQRoute;
:set HQRoute [ip route find dst-address=172.16.0.0/16];
:if ($HQRoute = "") do={
/ip route add distance=1 dst-address=172.16.0.0/16 gateway=l2tp-HQ_main pref-src=$ipLocalStore
/ip route remove [/ip route find static dst-address =172.16.1.0/24]
delay 4
/interface l2tp-client set l2tp-HQ_main add-default-route=no
}
#set user l2tp_tun_mira
/interface l2tp-client set l2tp-spb_A_main user=$l2tpUser password=$l2tpUserPass connect-to=spb-uvm.impsa.ru add-default-route=no

delay 30
:global PingControl;
:set PingControl [/ping 172.16.1.1 count=3];
:if ($PingControl <= 0 ) do={
:execute {/system backup load name=disconnect.backup password="secret"}
}  

}
