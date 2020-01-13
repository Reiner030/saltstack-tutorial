
# first we need nodejs installed:
nodejs-package:
  pkg.installed:
    - name: nodejs
    - retry:
        attempts: 20    # default: 2
        until: True     # default: True
        interval: 10    # default: 30
        splay: 10       # default: 0

# second we need npm installed:
npm-package:
  pkg.installed:
    - name: npm
    - retry:
        attempts: 20    # default: 2
        until: True     # default: True
        interval: 10    # default: 30
        splay: 10       # default: 0
    - require:
        - pkg: nodejs

# for ethercalc we should install also redis server:
redis-package:
  pkg.installed:
    - name: redis
    - retry:
        attempts: 20    # default: 2
        until: True     # default: True
        interval: 10    # default: 30
        splay: 10       # default: 0

ethercalc-npm-package:
  npm.installed:
    - name: ethercalc
    - require:
        - pkg: npm

/etc/systemd/system/ethercalc.service:
  file.managed:
    - name: /etc/systemd/system/ethercalc.service
    - contents: |
        [Unit]
        Description=Ethercalc Server
        Requires=redis-server.service
        After=redis-server.service

        [Service]
        ExecStart=/usr/local/bin/ethercalc
        # Required on some systems
        #WorkingDirectory=/opt/nodeserver
        Restart=always
        # Restart service after 10 seconds if node service crashes
        RestartSec=10
        # Output to syslog
        StandardOutput=syslog
        StandardError=syslog
        SyslogIdentifier=ethercalc
        #User=<alternate user>
        #Group=<alternate group>
        # Default ENV:
        #Environment=REDIS_HOST=localhost REDIS_PORT=6379 OPENSHIFT_DATA_DIR=process.cwd!
        # All possible keys:
        # REDIS_PORT REDIS_HOST REDIS_SOCKPATH REDIS_PASS REDIS_DB OPENSHIFT_DATA_DIR

        [Install]
        WantedBy=multi-user.target

/etc/rsyslog.d/30-ethercalc.conf:
  file.managed:
    - name: /etc/rsyslog.d/30-ethercalc.conf
    - contents: |
        :programname, isequal, "ethercalc" /var/log/ethercalc.log
    - require_in:
        - service: rsyslog.service
    - watch_in:
        - service: rsyslog.service

rsyslog-service:
  service:
    - name: rsyslog.service
    - running
    - enable: True
    - reload: False

ethercalc-service:
  service:
    - name: ethercalc.service
    - running
    - enable: True
    - require:
        - npm: ethercalc-npm-package
        - file: /etc/systemd/system/ethercalc.service
