# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if 'config' in phpstorm and phpstorm.config and phpstorm.config_file %}
    {%- if phpstorm.pkg.use_upstream_macapp %}
        {%- set sls_package_install = tplroot ~ '.macapp.install' %}
    {%- else %}
        {%- set sls_package_install = tplroot ~ '.archive.install' %}
    {%- endif %}

include:
  - {{ sls_package_install }}

phpstorm-config-file-managed-config_file:
  file.managed:
    - name: {{ phpstorm.config_file }}
    - source: {{ files_switch(['file.default.jinja'],
                              lookup='phpstorm-config-file-file-managed-config_file'
                 )
              }}
    - mode: 640
    - user: {{ phpstorm.identity.rootuser }}
    - group: {{ phpstorm.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
              {%- if phpstorm.pkg.use_upstream_macapp %}
        path: {{ phpstorm.pkg.macapp.path }}
              {%- else %}
        path: {{ phpstorm.pkg.archive.path }}
              {%- endif %}
        config: {{ phpstorm.config|json }}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}
