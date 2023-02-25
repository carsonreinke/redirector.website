#!/bin/bash

find /etc/letsencrypt/live -name cert.pem -exec $(which certbot) revoke --cert-path {} --delete-after-revoke --reason unspecified \;