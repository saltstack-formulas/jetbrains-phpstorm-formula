# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}

phpstorm-macos-app-clean-files:
  file.absent:
    - names:
      - {{ phpstorm.dir.tmp }}
      - /Applications/{{ phpstorm.pkg.name }}{{ '' if 'edition' in phpstorm else '\ %sE'|format(phpstorm.edition) }}.app   # noqa 204

    {%- else %}

phpstorm-macos-app-clean-unavailable:
  test.show_notification:
    - text: |
        The phpstorm macpackage is only available on MacOS

    {%- endif %}
