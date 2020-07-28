# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}

p-package-archive-clean-file-absent:
  file.absent:
    - names:
      - {{ phpstorm.dir.tmp }}
                  {%- if grains.os == 'MacOS' %}
      - {{ phpstorm.dir.path }}/{{ phpstorm.pkg.name }}*{{ phpstorm.edition }}*.app
                  {%- else %}
      - {{ phpstorm.dir.path }}
                  {%- endif %}
