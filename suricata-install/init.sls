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

suricata:
  pkgrepo.managed:
    - ppa: ppa:oisf/suricata-stable
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/suricata/suricata.yaml

#suricata-build:
#  - cmd.run: ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var && make && make install


/etc/suricata/suricata.yaml:
  file.managed:
    - source: salt://suricata-install/files/suricata.yaml
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

#/etc/default/suricata:
#  file.managed:
#    - source: salt://suricata-install/files/suricata-default-config
#    - user: root
#    - group: root
#    - mode: 644
#    - require:
#        - pkg: suricata
