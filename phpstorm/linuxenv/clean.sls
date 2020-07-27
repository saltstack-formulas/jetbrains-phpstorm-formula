# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {% if grains.kernel|lower == 'linux' %}

phpstorm-linuxenv-home-file-absent:
  file.absent:
    - names:
      - /opt/phpstorm
      - {{ phpstorm.dir.path }}

        {% if phpstorm.linux.altpriority|int > 0 and grains.os_family not in ('Arch',) %}

phpstorm-linuxenv-home-alternatives-clean:
  alternatives.remove:
    - name: phpstormhome
    - path: {{ phpstorm.dir.path }}
    - onlyif: update-alternatives --get-selections |grep ^phpstormhome


phpstorm-linuxenv-executable-alternatives-clean:
  alternatives.remove:
    - name: phpstorm
    - path: {{ phpstorm.dir.path }}/{{ phpstorm.command }}
    - onlyif: update-alternatives --get-selections |grep ^phpstorm

        {%- else %}

phpstorm-linuxenv-alternatives-clean-unapplicable:
  test.show_notification:
    - text: |
        Linux alternatives are turned off (phpstorm.linux.altpriority=0),
        or not applicable on {{ grains.os or grains.os_family }} OS.
        {% endif %}
    {% endif %}
