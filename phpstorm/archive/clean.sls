# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}

phpstorm-package-archive-clean-file-absent:
  file.absent:
    - names:
      - {{ phpstorm.pkg.archive.path }}
      - /usr/local/jetbrains/phpstorm-*
