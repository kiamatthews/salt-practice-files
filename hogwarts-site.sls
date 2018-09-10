include:
  - nodejs-package # this makes content from another state file available to be referenced in this file

hogwarts-site-user:
  user.present:
     - name: hogwarts_www
     - home: /home/hogwarts_www

#### cloning files from git repo ####
#hogwarts-source:
#  git.latest:
#     - name: https://github.com/kiamatthews/hogwarts-site.git
#     - rev: master
#     - target: /home/hogwarts_www/site
#     - require:
#        - user: hogwarts_www #this state won't run unless the user is present
#        - sls: nodejs-package #this state won't run unless the steps from this other state were completed

#### using gitfs and managed files ####
/home/hogwarts_www/site:
  file.recurse:
     - source: salt://hogwarts-site
     - user: hogwarts_www

hogwarts-npm-install:
  cmd.wait:
    - name: npm install
    - cwd: /home/hogwarts_www/site
    - onchanges:
      - file: salt://hogwarts-site/* # this state only runs if hogwarts source state is run (ie: the files in that dir change)

hogwarts-build-script:
  cmd.wait:
    - name: npm run-script build
    - cwd: /home/hogwarts_www/site
    - onchanges:
      - file: /home/hogwarts_www/site/*
