###  Mostly from: https://dev.deluge-torrent.org/wiki/UserGuide/Service/systemd

### headless
```
apt-get install deluged deluge-web
sudo chsh -s /usr/sbin/nologin deluge
```

```
cat <<EOF > /etc/systemd/system/deluged.service
[Unit]
Description=Deluge Bittorrent Client Daemon
Documentation=man:deluged
After=network-online.target
[Service]
Type=simple
User=deluge
Group=deluge
UMask=007
ExecStart=/usr/bin/deluged -d -l /var/log/deluge/daemon.log -L warning
Restart=on-failure
# Time to wait before forcefully stopped.
TimeoutStopSec=300
[Install]
WantedBy=multi-user.target
EOF
```
```
cat <<EOF > /etc/systemd/system/deluge-web.service
[Unit]
Description=Deluge Bittorrent Client Web Interface
Documentation=man:deluge-web
After=network-online.target deluged.service
Wants=deluged.service
[Service]
Type=simple
User=deluge
Group=deluge
UMask=027
# This 5 second delay is necessary on some systems
# to ensure deluged has been fully started
ExecStartPre=/bin/sleep 5
ExecStart=/usr/bin/deluge-web -l /var/log/deluge/web.log -L warning
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
```

```
cat <<EOF > /etc/logrotate.d/deluge
/var/log/deluge/*.log {
        rotate 4
        weekly
        missingok
        notifempty
        compress
        delaycompress
        sharedscripts
        postrotate
                systemctl restart deluged >/dev/null 2>&1 || true
                systemctl restart deluge-web >/dev/null 2>&1 || true
        endscript
}
EOF
```
```
sudo mkdir -p /var/log/deluge
sudo chown -R deluge:deluge /var/log/deluge
sudo chmod -R 750 /var/log/deluge
```

```
sudo systemctl enable /etc/systemd/system/deluged.service
sudo systemctl start deluged
sudo systemctl status deluged
sudo systemctl enable /etc/systemd/system/deluge-web.service
sudo systemctl start deluge-web
sudo systemctl status deluge-web
```
