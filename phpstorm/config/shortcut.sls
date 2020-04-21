# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if phpstorm.linux.install_desktop_file and grains.os not in ('MacOS',) %}
       {%- if phpstorm.pkg.use_upstream_macapp %}
           {%- set sls_package_install = tplroot ~ '.macapp.install' %}
       {%- else %}
           {%- set sls_package_install = tplroot ~ '.archive.install' %}
       {%- endif %}

include:
  - {{ sls_package_install }}

phpstorm-config-file-file-managed-desktop-shortcut_file:
  file.managed:
    - name: {{ phpstorm.linux.desktop_file }}
    - source: {{ files_switch(['shortcut.desktop.jinja'],
                              lookup='phpstorm-config-file-file-managed-desktop-shortcut_file'
                 )
              }}
    - mode: 644
    - user: {{ phpstorm.identity.user }}
    - makedirs: True
    - template: jinja
    - context:
        appname: {{ phpstorm.pkg.name }}
        edition: {{ phpstorm.edition|json }}
        command: {{ phpstorm.command|json }}
              {%- if phpstorm.pkg.use_upstream_macapp %}
        path: {{ phpstorm.pkg.macapp.path }}
    - onlyif: test -f "{{ phpstorm.pkg.macapp.path }}/{{ phpstorm.command }}"
              {%- else %}
        path: {{ phpstorm.pkg.archive.path }}
    - onlyif: test -f {{ phpstorm.pkg.archive.path }}/{{ phpstorm.command }}
              {%- endif %}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}
