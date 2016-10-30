#!/bin/bash

d="grassmucks.com"
subs=(www stats plex reqs sonarr cp plexpy nzb mail webmail torrents znc)
email="ricky.grassmuck@gmail.com"

len=${#subs[@]}
i=0
declare -a opts=()

while [ $i -lt ${len} ]
do
	opts=(${opts[@]} "-d ${subs[$i]}.${d}")
	i=$(( $i + 1 ))
done

function getcerts {
	/usr/bin/certbot certonly \
		--pre-hook "systemctl stop nginx" \
		--post-hook "systemctl start nginx" \
		--standalone \
		--agree-tos \
		--email ${email} \
		-d ${d} \
		${opts[@]}

}

getcerts
