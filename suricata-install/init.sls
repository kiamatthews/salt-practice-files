{% set version = '4.0.0' %}

suricata-deps:
  pkg:
    - latest
    - names:
      - libprcre3
      - libprcre3-dbg
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
  pkg:
    - installed
    - source: https://www.openinfosecfoundation.org/downloads/suricata-{{ version }}.tar.gz
    - cwd: suricata-{{ version }}
    - cmd.run: ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var && make && make install
  service:
    - running
    - watch:
      - file: /etc/suricata/suricata.yml


/etc/suricata/suricata.yml:
  file.managed:
    - source: salt://suricata-install/files/suricata.yml
    - user: root
    - group: root
    - mode: 644
    - require:
        - pkg: suricata

/etc/suricata/rules:
  file.recurse:
    - source: salt://suricata-install/files/rules
    - user: root
    - group: root
    - mode: 644
    - require:
        - pkg: suricata
