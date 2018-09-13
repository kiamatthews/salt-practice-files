suricata-deps:
  pkg:
    - latest
    - names:
      - libpcre3
      - libpcre3-dbg
      - libpcre3-dev
      - build-essential
      - make
      - libpcap-dev
      - libnet1-dev
      - libyaml-0-2
      - libyaml-dev
      - zlib1g
      - zlib1g-dev
      - libmagic-dev
      - libcap-ng-dev
      - libcap-ng0
      - libnss3-dev
      - libgeoip-dev
      - liblua5.1-dev
      - libhiredis-dev
      - libevent-dev
      - libjansson-dev
      - pkg-config

suricata-repo:
  pkgrepo.managed:
    - ppa: oisf/suricata-stable

suricata:
  pkg.installed:
    - require:
      - pkgrepo.managed: suricata-repo
  service.running:
    - watch:
      - file: /etc/suricata/suricata.yaml

/etc/default/suricata:
  file.managed:
    - source: salt://suricata-install/files/suricata-default-config
    - user: root
    - group: root
    - mode: 644
    - require:
        - pkg: suricata

/etc/suricata/rules:
  file.recurse:
    - source: salt://suricata-install/files/rules
    - require:
        - pkg: suricata

/etc/suricata/suricata.yaml:
  file.managed:
    - source: salt://suricata-install/files/suricata.yaml
    - user: root
    - group: root
    - mode: 644
    - require:
        - pkg: suricata
