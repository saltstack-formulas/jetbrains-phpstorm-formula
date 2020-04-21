# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}

phpstorm-macos-app-clean-files:
  file.absent:
    - names:
      - {{ phpstorm.dir.tmp }}
      - /Applications/{{ phpstorm.pkg.name }}{{ ' %sE'|format(phpstorm.edition) if phpstorm.edition else '' }}.app

    {%- else %}

phpstorm-macos-app-clean-unavailable:
  test.show_notification:
    - text: |
        The phpstorm macpackage is only available on MacOS

    {%- endif %}
