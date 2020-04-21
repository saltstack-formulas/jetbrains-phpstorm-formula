# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

phpstorm-package-archive-install:
  pkg.installed:
    - names: {{ phpstorm.pkg.deps|json }}
    - require_in:
      - file: phpstorm-package-archive-install
  file.directory:
    - name: {{ phpstorm.pkg.archive.path }}
    - user: {{ phpstorm.identity.rootuser }}
    - group: {{ phpstorm.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: phpstorm-package-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(phpstorm.pkg.archive) }}
    - retry: {{ phpstorm.retry_option|json }}
    - user: {{ phpstorm.identity.rootuser }}
    - group: {{ phpstorm.identity.rootgroup }}
    - recurse:
        - user
        - group
    - require:
      - file: phpstorm-package-archive-install

    {%- if phpstorm.linux.altpriority|int == 0 %}

phpstorm-archive-install-file-symlink-phpstorm:
  file.symlink:
    - name: /usr/local/bin/phpstorm
    - target: {{ phpstorm.pkg.archive.path }}/{{ phpstorm.command }}
    - force: True
    - onlyif: {{ grains.kernel|lower != 'windows' }}
    - require:
      - archive: phpstorm-package-archive-install

    {%- endif %}
