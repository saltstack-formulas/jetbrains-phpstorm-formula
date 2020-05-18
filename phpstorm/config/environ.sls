# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- if phpstorm.pkg.use_upstream_macapp %}
        {%- set sls_package_install = tplroot ~ '.macapp.install' %}
    {%- else %}
        {%- set sls_package_install = tplroot ~ '.archive.install' %}
    {%- endif %}

include:
  - {{ sls_package_install }}

phpstorm-config-file-file-managed-environ_file:
  file.managed:
    - name: {{ phpstorm.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='phpstorm-config-file-file-managed-environ_file'
                 )
              }}
    - mode: 644
    - user: {{ phpstorm.identity.rootuser }}
    - group: {{ phpstorm.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
              {%- if phpstorm.pkg.use_upstream_macapp %}
        path: '/Applications/{{ phpstorm.pkg.name }}{{ '\ %sE'|format(phpstorm.edition) }}.app/Contents/MacOS'
              {%- else %}
        path: {{ phpstorm.pkg.archive.path }}/bin
              {%- endif %}
        environ: {{ phpstorm.environ|json }}
    - require:
      - sls: {{ sls_package_install }}
