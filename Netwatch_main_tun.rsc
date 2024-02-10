{
    #-------------------------------------------------------------------------------
    #
    # The purpose of this script is to create whatchdog if down connect to HQ ans SPB
    # 
    #
    #-------------------------------------------------------------------------------

#add system scrip
/system script remove Reboot_if_down_HQ_and_SPB
/system script add name="Reboot_if_down_HQ_and_SPB" dont-require-permissions=yes source={/log warning "server 172.16.1.1 fail..."
:local checkip [/ping 172.16.2.1 count=5]
:if (checkip = 0) do={
/system reboot
}}

#add netwatch rule
/tool netwatch
add host=172.16.1.1 interval=15m timeout=5s comment="Reboot_if_down_HQ_and_SPB" down-script="Reboot_if_down_HQ_and_SPB"
}
