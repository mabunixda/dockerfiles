#!/bin/sh
if [ -f /data/sonos_nolb.cfg ]; then
    echo "using custom sonos config"
    rm -f /loxone-sonos/webfrontend/html/system/sonos_nolb.cfg
    ln -sf /data/sonos_nolb.cfg /loxone-sonos/webfrontend/html/system/sonos_nolb.cfg
fi
if [ -f /data/player_nolb.cfg ]; then
    echo "using custom player config"
    rm -f /loxone-sonos/webfrontend/html/system/player_nolb.cfg
    ln -sf /data/player_nolb.cfg /loxone-sonos/webfrontend/html/system/player_nolb.cfg
fi

chown -R $UID:$GID /loxone-sonos /etc/nginx /etc/php7 /var/log /var/lib/nginx /tmp /etc/s6.d
exec su-exec $UID:$GID /bin/s6-svscan /etc/s6.d
