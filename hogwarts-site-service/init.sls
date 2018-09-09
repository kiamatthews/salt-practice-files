include:
  - hogwarts-site

supervisor:
  pkg.installed:
  - require:
     - sls: hogwarts-site
  service.running:
    - watch:
      - file: /etc/supervisor/conf.d/hogwarts-site.conf

/etc/supervisor/conf.d/hogwarts-site.conf:
  file.managed:
    - source: salt://hogwarts-site-service/supervisor.conf
    - require:
      - pkg: supervisor
    
