# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}

    {%- if grains.kernel|lower in ('windows', 'linux', 'darwin',) %}

include:
  - {{ '.macapp' if phpstorm.pkg.use_upstream_macapp else '.archive' }}
  - .config
  - .linuxenv

    {%- else %}

phpstorm-not-available-to-install:
  test.show_notification:
    - text: |
        The phpstorm package is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
