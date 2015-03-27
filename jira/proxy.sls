{%- from 'jira/conf/settings.sls' import jira with context %}


apache:
  pkg.installed:
    - pkgs:
       - apache2
  service.running:
    - name: apache2
    - enable: True
    - require:
      - pkg: apache

apache-restart:
  module.wait:
    - name: service.restart
    - m_name: apache2

apache-reload:
  module.wait:
    - name: service.reload
    - m_name: apache2

jira-vhost:
  file.managed:
    - name: /etc/apache2/sites-available/jira
    - source: salt://jira/templates/jira-vhost.tmpl


disable-default-site:
  file.absent:
    - name: /etc/apache2/sites-enabled/default
    - watch_in:
      - module: apache-reload

enable-jira-site:
  file.symlink:
    - name: /etc/apache2/sites-enabled/jira
    - target: /etc/apache2/sites-available/jira
    - watch_in:
      - module: apache-reload
 
# a2ensite jira:
#   cmd.wait:
#     - stateful: True
#     - require:
#       - pkg: apache
#       - cmd: a2dissite 000-default
#     - watch:
#       - file: jira-vhost
#     - watch_in:
#       - apache-restart

a2enmod proxy:
  cmd.wait:
    - watch:
      - pkg: apache
    - watch_in:
      - module: apache-restart

a2enmod proxy_http:
  cmd.wait:
    - watch:
      - pkg: apache
    - watch_in:
      - module: apache-restart
