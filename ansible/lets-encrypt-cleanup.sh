#!/bin/bash

$(which certbot) certificates | grep --color=none -o -P "(?<=Domains: )(.+)" | while IFS= read -r DOMAIN; do
    #Digital Ocean specific method to retrieve floating IP address
    #See https://www.digitalocean.com/docs/networking/floating-ips/how-to/find-anchor-ips/
    #FLOATING_IP=$(curl -s http://169.254.169.254/metadata/v1/floating_ip/ipv4/ip_address | grep --color=never -o -P "([0-9\.]+)" | tr -d "\n")
    FLOATING_IP="45.55.123.140"

    #Get the IP address 
    DOMAIN_IP=$(host -t a $DOMAIN | grep --color=never -o -P "(?<=has address )([0-9\.]+)" | tr -d "\n")

    if [[ $FLOATING_IP != $DOMAIN_IP ]]; then
        $(which certbot) delete -n -q --cert-name $DOMAIN
        DIRECTORY="/var/local/www/$DOMAIN"
        if [[ -d $DIRECTORY ]]; then
            rm -Rf $DIRECTORY
        fi
    fi
done

$(which systemctl) kill -s SIGHUP nginx.service