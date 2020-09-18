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
    {%- if grains.os != 'Windows' %}

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
      environ: {{ phpstorm.environ|json }}
                      {%- if phpstorm.pkg.use_upstream_macapp %}
      edition:  {{ '' if not phpstorm.edition else ' %sE'|format(phpstorm.edition) }}.app/Contents/MacOS
      appname: {{ phpstorm.dir.path }}/{{ phpstorm.pkg.name }}
                      {%- else %}
      edition: ''
      appname: {{ phpstorm.dir.path }}/bin
                      {%- endif %}
    - require:
      - sls: {{ sls_package_install }}

    {%- endif %}
