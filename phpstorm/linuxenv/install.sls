# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {% if grains.kernel|lower == 'linux' %}

phpstorm-linuxenv-home-file-symlink:
  file.symlink:
    - name: /opt/phpstorm
    - target: {{ phpstorm.dir.path }}
    - onlyif: test -d '{{ phpstorm.dir.path }}'
    - force: True

        {% if phpstorm.linux.altpriority|int > 0 and grains.os_family not in ('Arch',) %}

phpstorm-linuxenv-home-alternatives-install:
  alternatives.install:
    - name: phpstormhome
    - link: /opt/phpstorm
    - path: {{ phpstorm.dir.path }}
    - priority: {{ phpstorm.linux.altpriority }}
    - retry: {{ phpstorm.retry_option|json }}

phpstorm-linuxenv-home-alternatives-set:
  alternatives.set:
    - name: phpstormhome
    - path: {{ phpstorm.dir.path }}
    - onchanges:
      - alternatives: phpstorm-linuxenv-home-alternatives-install
    - retry: {{ phpstorm.retry_option|json }}

phpstorm-linuxenv-executable-alternatives-install:
  alternatives.install:
    - name: phpstorm
    - link: {{ phpstorm.linux.symlink }}
    - path: {{ phpstorm.dir.path }}/{{ phpstorm.command }}
    - priority: {{ phpstorm.linux.altpriority }}
    - require:
      - alternatives: phpstorm-linuxenv-home-alternatives-install
      - alternatives: phpstorm-linuxenv-home-alternatives-set
    - retry: {{ phpstorm.retry_option|json }}

phpstorm-linuxenv-executable-alternatives-set:
  alternatives.set:
    - name: phpstorm
    - path: {{ phpstorm.dir.path }}/{{ phpstorm.command }}
    - onchanges:
      - alternatives: phpstorm-linuxenv-executable-alternatives-install
    - retry: {{ phpstorm.retry_option|json }}

        {%- else %}

phpstorm-linuxenv-alternatives-install-unapplicable:
  test.show_notification:
    - text: |
        Linux alternatives are turned off (phpstorm.linux.altpriority=0),
        or not applicable on {{ grains.os or grains.os_family }} OS.
        {% endif %}
    {% endif %}
