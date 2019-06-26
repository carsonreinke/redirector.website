#!/bin/bash

#Loop through each domain
cat /var/log/nginx/access.log | sort | uniq | while IFS= read -r DOMAIN; do
    #Digital Ocean specific method to retrieve floating IP address
    #See https://www.digitalocean.com/docs/networking/floating-ips/how-to/find-anchor-ips/
    FLOATING_IP=$(curl -s http://169.254.169.254/metadata/v1/floating_ip/ipv4/ip_address | grep --color=never -o -P "([0-9\.]+)" | tr -d "\n")

    #Get the IP address 
    DOMAIN_IP=$(host -t a $DOMAIN | grep --color=never -o -P "(?<=has address )([0-9\.]+)" | tr -d "\n")

    if [[ $FLOATING_IP == $DOMAIN_IP ]]; then
        DIRECTORY="/var/local/www/$DOMAIN"
        if [[ ! -d $DIRECTORY ]]; then
            mkdir $DIRECTORY
        fi
        $(which certbot) certonly -n -q --webroot -w "/var/local/www/$DOMAIN" -d "$DOMAIN"
    fi
done

#Flush Nginx log
rm /var/log/nginx/access.log
$(which systemctl) kill -s SIGUSR1 nginx.service