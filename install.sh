#!/bin/bash

led_servername="${led_servername:-$1}"

appconf="${led_appconf:-`pwd`/data/nginx/app.conf}"
appconf_example="${led_appconf_example:-`pwd`/app.conf.example}"

placeholder="YOUR_SERVER_NAME"

error() {
    echo "ERROR: $1"
}

warn() {
    echo "WARN: $1"
}

ask_proceed() {
    read -p "Are you sure you want to proceed? [y/N] " decision

    if [[ ! "${decision}" =~ ^[Yy]$ ]]; then
        return 1
    fi

    return 0
}

if [ -z "${led_servername}" ]; then
    read -p "What is the dns name which require a certificate? (enter a valid dns name): " led_servername

    if [ -z "${led_servername}" ]; then
        warn "You entered an empty server name"
    fi

    if ! $(host "${led_servername}" 2>&1 > /dev/null); then
        warn "Could not find the server name"
    fi
fi

if [ ! -f "${appconf_example}" ]; then
    error "Could not find given blueprint config file at ${appconf_example}"
fi

if [ -f "${appconf}" ]; then
    warn "Found nginx config file at ${appconf}"
    is_overwrite=0
fi

echo "Summary"
echo "  Server name = ${led_servername}"
echo "  Nginx conf file = ${appconf}"
[ "${is_overwrite:-1}" -eq 0 ] && echo "  Overwrite nginx config file? yes"

ask_proceed || exit

mkdir -p $(dirname "${appconf}")
cp -f "${appconf_example}" "${appconf}"

sed -i -e "s/${placeholder}/${led_servername}/g" "${appconf}"

