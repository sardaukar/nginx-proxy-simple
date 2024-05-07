#!/usr/bin/env sh

if [ ! -n "$SERVER_NAME" ] ; then
    echo "Environment variable SERVER_NAME is not set, exiting."
    exit 1
fi

if [ ! -n "$PROXY_PROTO" ] ; then
    echo "Environment variable PROXY_PROTO is not set, exiting."
    exit 1
fi

if [ ! -n "$PROXY_TARGET_IP" ] ; then
    echo "Environment variable PROXY_TARGET_IP is not set, exiting."
    exit 1
fi

if [ ! -n "$PROXY_TARGET_PORT" ] ; then
    echo "Environment variable PROXY_TARGET_PORT is not set, exiting."
    exit 1
fi

sed -i "s|\${SERVER_NAME}|${SERVER_NAME}|" /etc/nginx/conf.d/default.conf
sed -i "s|\${PROXY_TARGET_IP}|${PROXY_TARGET_IP}|" /etc/nginx/conf.d/default.conf
sed -i "s|\${PROXY_TARGET_PORT}|${PROXY_TARGET_PORT}|" /etc/nginx/conf.d/default.conf
sed -i "s|\${PROXY_PROTO}|${PROXY_PROTO}|" /etc/nginx/conf.d/default.conf

exec nginx -g 'daemon off;'
