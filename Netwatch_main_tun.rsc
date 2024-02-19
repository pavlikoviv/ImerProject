{
    #-------------------------------------------------------------------------------
    #
    # The purpose of this script is to create whatchdog if down connect to HQ ans SPB
    # 
    #
    #-------------------------------------------------------------------------------

#add system scrip
/system script remove [find name=Reboot_if_down_HQ_and_SPB]
/system script add name="Reboot_if_down_HQ_and_SPB" dont-require-permissions=yes source={/log warning "server 172.16.1.1 fail..."
:if [/interface find name=lte1] do={/log warning "rebooting USB..";/system routerboard usb power-reset}
/log warning "Start timer 10min";
:if ([/ping 172.16.1.1 interval=1 count=600] =0) do={
/system reboot}
/log warning "Skip reboot";
}

#add netwatch rule
/tool netwatch remove [find comment="Reboot_if_down_HQ_and_SPB"]
/tool netwatch
add host=172.16.1.1 interval=15m timeout=5s comment="Reboot_if_down_HQ_and_SPB" down-script="Reboot_if_down_HQ_and_SPB"
}
