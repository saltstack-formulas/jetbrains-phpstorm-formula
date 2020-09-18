# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

phpstorm-package-archive-install:
              {%- if grains.os == 'Windows' %}
  chocolatey.installed:
    - force: False
              {%- else %}
  pkg.installed:
              {%- endif %}
    - names: {{ phpstorm.pkg.deps|json }}
    - require_in:
      - file: phpstorm-package-archive-install

              {%- if phpstorm.flavour|lower == 'windows' %}

  file.managed:
    - name: {{ phpstorm.dir.tmp }}/phpstorm.exe
    - source: {{ phpstorm.pkg.archive.source }}
    - makedirs: True
    - source_hash: {{ phpstorm.pkg.archive.source_hash }}
    - force: True
  cmd.run:
    - name: {{ phpstorm.dir.tmp }}/phpstorm.exe
    - require:
      - file: phpstorm-package-archive-install

              {%- else %}

  file.directory:
    - name: {{ phpstorm.dir.path }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: phpstorm-package-archive-install
                 {%- if grains.os != 'Windows' %}
    - user: {{ phpstorm.identity.rootuser }}
    - group: {{ phpstorm.identity.rootgroup }}
    - recurse:
        - user
        - group
        - mode
                 {%- endif %}
  archive.extracted:
    {{- format_kwargs(phpstorm.pkg.archive) }}
    - retry: {{ phpstorm.retry_option|json }}
                 {%- if grains.os != 'Windows' %}
    - user: {{ phpstorm.identity.rootuser }}
    - group: {{ phpstorm.identity.rootgroup }}
    - recurse:
        - user
        - group
                 {%- endif %}
    - require:
      - file: phpstorm-package-archive-install

              {%- endif %}
              {%- if grains.kernel|lower == 'linux' and phpstorm.linux.altpriority|int == 0 %}

phpstorm-archive-install-file-symlink-phpstorm:
  file.symlink:
    - name: /usr/local/bin/{{ phpstorm.command }}
    - target: {{ phpstorm.dir.path }}/{{ phpstorm.command }}
    - force: True
    - onlyif: {{ grains.kernel|lower != 'windows' }}
    - require:
      - archive: phpstorm-package-archive-install

              {%- elif phpstorm.flavour|lower == 'windowszip' %}

phpstorm-archive-install-file-shortcut-phpstorm:
  file.shortcut:
    - name: C:\Users\{{ phpstorm.identity.rootuser }}\Desktop\{{ phpstorm.dirname }}.lnk
    - target: {{ phpstorm.dir.archive }}\{{ phpstorm.dirname }}\{{ phpstorm.command }}
    - working_dir: {{ phpstorm.dir.archive }}\{{ phpstorm.dirname }}\bin
    - icon_location: {{ phpstorm.dir.archive }}\{{ phpstorm.dirname }}\bin\phpstorm.ico
    - makedirs: True
    - force: True
    - user: {{ phpstorm.identity.rootuser }}
    - require:
      - archive: phpstorm-package-archive-install

              {%- endif %}
