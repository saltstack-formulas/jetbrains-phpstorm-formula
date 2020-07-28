# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if phpstorm.shortcut.install and grains.kernel|lower == 'linux' %}
    {%- set sls_package_install = tplroot ~ '.archive.install' %}

include:
  - {{ sls_package_install }}

phpstorm-config-file-file-managed-desktop-shortcut_file:
  file.managed:
    - name: {{ phpstorm.shortcut.file }}
    - source: {{ files_switch(['shortcut.desktop.jinja'],
                              lookup='phpstorm-config-file-file-managed-desktop-shortcut_file'
                 )
              }}
    - mode: 644
    - user: {{ phpstorm.identity.user }}
    - makedirs: True
    - template: jinja
    - context:
      command: {{ phpstorm.command|json }}
                        {%- if grains.os == 'MacOS' %}
      edition: {{ '' if 'edition' not in phpstorm else phpstorm.edition|json }}
      appname: {{ phpstorm.dir.path }}/{{ phpstorm.pkg.name }}
                        {%- else %}
      edition: ''
      appname: {{ phpstorm.dir.path }}
    - onlyif: test -f "{{ phpstorm.dir.path }}/{{ phpstorm.command }}"
                        {%- endif %}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}
