#!/bin/sh
#######################################################################################
## This script is used to automatically renew the Let's Encrypt certificate
## Author: Tiago França - github.com/tiagofrancafernandes
## 1st version date: 2022-06-02
## Last updated date: 2022-06-02
#######################################################################################

HEALTH_CHECK_ID="3cf70036-0fcb-474e-81b1-425567541a22"

sudo certbot certificates |tee /tmp/certbot-certificates.out >> /dev/null

## A saída será algo como:
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## Found the following certs:
##   Certificate Name: domain1.com.br
##     Domains: domain1.com.br
##     Expiry Date: 2022-08-28 17:41:57+00:00 (VALID: 86 days)
##     Certificate Path: /etc/letsencrypt/live/domain1.com.br/fullchain.pem
##     Private Key Path: /etc/letsencrypt/live/domain1.com.br/privkey.pem
##   Certificate Name: domain2.com.br
##     Domains: domain2.com.br
##     Expiry Date: 2022-08-28 17:40:25+00:00 (VALID: 86 days)
##     Certificate Path: /etc/letsencrypt/live/domain2.com.br/fullchain.pem
##     Private Key Path: /etc/letsencrypt/live/domain2.com.br/privkey.pem
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

DOMAIN_COUNT=$(grep -R 'Domains\:' /tmp/certbot-certificates.out|wc -l)
VALID_COUNT=$(grep -R 'VALID\:' /tmp/certbot-certificates.out|wc -l)

curl --retry 3 "https://hc-ping.com/${HEALTH_CHECK_ID}/$?"

if [ $DOMAIN_COUNT -eq $VALID_COUNT ]; then
  echo "Todos os certificados são válidos"
  exit 0
fi

echo "Há certificados inválidos"

## Aqui chamar a API para liberar para TODOS o acesso para as portas 443 e 80 para que o Let's Encrypt possa renovar os certificados
## TODO: Implementar chamada para a API do cloud e dar um delay de alguns segundos/minutos e então continuar

## Aqui chamar o certbot para renovar os certificados inválidos
/usr/bin/certbot renew

## Aqui fazer ação de health check informando se a ação foi executado com sucesso
## https://healthchecks.io/docs/signaling_failures/
curl --retry 3 "https://hc-ping.com/${HEALTH_CHECK_ID}/$?"

exit 1
