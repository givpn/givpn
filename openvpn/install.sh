#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V2.0
# Auther  : givpn
# (C) Copyright 2023
# =========================================
# pewarna hidup
BGreen='\e[1;32m'
NC='\e[0m'
clear
cd
rm -rf /usr/bin/usernew
rm -rf /usr/bin/trial
echo "\e[1;32m Update Menu.. \e[0m"
sleep 1
wget -q -O /usr/bin/usernew https://raw.githubusercontent.com/givpn/givpn/master/openvpn/ssh/usernew.sh
wget -q -O /usr/bin/trial https://raw.githubusercontent.com/givpn/givpn/master/openvpn/ssh/trial.sh
chmod +x /usr/bin/usernew
chmod +x /usr/bin/trial
MYIP=$(wget -qO- ifconfig.co);
MYIP2="s/xxxxxxxxx/$MYIP/g";
# // install squid for debian 9,10 & ubuntu 20.04
apt -y install squid3

# install squid for debian 9,10 & ubuntu 20.04
sleep 1
echo "\e[1;32m Proses Download squid.. \e[0m"
apt -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/givpn/givpn/master/openvpn/squid3.conf"
sed -i $MYIP2 /etc/squid/squid.conf

# // OpenVPN
sleep 1
echo "\e[1;32m Proses Download OpenVPN.. \e[0m"
wget https://raw.githubusercontent.com/givpn/givpn/master/openvpn/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh

cd
chown -R www-data:www-data /home/vps/public_html
sleep 0.5
echo -e "$BGreen[SERVICE]$NC Restart All service SSH & OVPN"
/etc/init.d/nginx restart >/dev/null 2>&1
sleep 0.5
echo -e "[ ${BGreen}ok${NC} ] Restarting nginx"
/etc/init.d/openvpn restart >/dev/null 2>&1
sleep 0.5
echo -e "[ ${BGreen}ok${NC} ] Restarting cron "
/etc/init.d/ssh restart >/dev/null 2>&1
sleep 0.5
echo -e "[ ${BGreen}ok${NC} ] Restarting ssh "
/etc/init.d/dropbear restart >/dev/null 2>&1
sleep 0.5
echo -e "[ ${BGreen}ok${NC} ] Restarting dropbear "
/etc/init.d/fail2ban restart >/dev/null 2>&1
sleep 0.5
echo -e "[ ${BGreen}ok${NC} ] Restarting fail2ban "
/etc/init.d/stunnel4 restart >/dev/null 2>&1
sleep 0.5
echo -e "[ ${BGreen}ok${NC} ] Restarting stunnel4 "
/etc/init.d/vnstat restart >/dev/null 2>&1
sleep 0.5
echo -e "[ ${BGreen}ok${NC} ] Restarting vnstat "
/etc/init.d/squid restart >/dev/null 2>&1
clear
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                  : 22"  | tee -a log-install.txt
echo "   - OpenVPN                  : TCP 1194"  | tee -a log-install.txt
echo "   - Squid Proxy              : 3128, 8000 (limit to IP Server)"  | tee -a log-install.txt
echo "   - SSH Websocket            : 80" | tee -a log-install.txt
echo "   - SSH SSL Websocket        : 443" | tee -a log-install.txt
echo "   - Stunnel4                 : 222, 777" | tee -a log-install.txt
echo "   - Dropbear                 : 109, 143" | tee -a log-install.txt
echo "   - Badvpn                   : 7100-7900" | tee -a log-install.txt
echo "   - Nginx                    : 81" | tee -a log-install.txt
echo "   - Vmess WS TLS             : 443" | tee -a log-install.txt
echo "   - Vless WS TLS             : 443" | tee -a log-install.txt
echo "   - Trojan WS TLS            : 443" | tee -a log-install.txt
echo "   - Shadowsocks WS TLS       : 443" | tee -a log-install.txt
echo "   - Vmess WS none TLS        : 80" | tee -a log-install.txt
echo "   - Vless WS none TLS        : 80" | tee -a log-install.txt
echo "   - Trojan WS none TLS       : 80" | tee -a log-install.txt
echo "   - Shadowsocks WS none TLS  : 80" | tee -a log-install.txt
echo "   - Vmess gRPC               : 443" | tee -a log-install.txt
echo "   - Vless gRPC               : 443" | tee -a log-install.txt
echo "   - Trojan gRPC              : 443" | tee -a log-install.txt
echo "   - Shadowsocks gRPC         : 443" | tee -a log-install.txt
clear
rm -rf install.sh
echo -e "\e[1;32m auto reboot in 5s \e[0m"
sleep 5
reboot

