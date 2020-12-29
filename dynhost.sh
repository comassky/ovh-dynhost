#!/bin/sh

echo $(date)
domains=$(echo $DYNHOST_DOMAIN_NAME | xargs | tr "," "\n")

for domain in $domains
do
  IP=$(dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr -d \")
  CURRENT_IP=$(dig +short $domain)
  if [ "$IP" ]; then
    if [ "$CURRENT_IP" != "$IP" ]; then
        echo "Updating $domain from $CURRENT_IP to $IP"
        curl --user "${DYNHOST_LOGIN}:${DYNHOST_PASSWORD}" "http://www.ovh.com/nic/update?system=dyndns&hostname=${domain}&myip=${IP}"
    else
       echo "No update required for $domain"
    fi
  else
    echo "IP not found for $domain"
  fi
done
