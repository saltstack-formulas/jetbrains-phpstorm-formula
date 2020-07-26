# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}

phpstorm-macos-app-install-curl:
  file.directory:
    - name: {{ phpstorm.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - name: curl
  cmd.run:
    - name: curl -Lo {{ phpstorm.dir.tmp }}/phpstorm-{{ phpstorm.version }} "{{ phpstorm.pkg.macapp.source }}"
    - unless: test -f {{ phpstorm.dir.tmp }}/phpstorm-{{ phpstorm.version }}
    - require:
      - file: phpstorm-macos-app-install-curl
      - pkg: phpstorm-macos-app-install-curl
    - retry: {{ phpstorm.retry_option|json }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
phpstorm-macos-app-install-checksum:
  module.run:
    - onlyif: {{ phpstorm.pkg.macapp.source_hash }}
    - name: file.check_hash
    - path: {{ phpstorm.dir.tmp }}/phpstorm-{{ phpstorm.version }}
    - file_hash: {{ phpstorm.pkg.macapp.source_hash }}
    - require:
      - cmd: phpstorm-macos-app-install-curl
    - require_in:
      - macpackage: phpstorm-macos-app-install-macpackage
  file.absent:
    - name: {{ phpstorm.dir.tmp }}/phpstorm-{{ phpstorm.version }}
    - onfail:
      - module: phpstorm-macos-app-install-checksum

phpstorm-macos-app-install-macpackage:
  macpackage.installed:
    - name: {{ phpstorm.dir.tmp }}/phpstorm-{{ phpstorm.version }}
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - cmd: phpstorm-macos-app-install-curl
  file.managed:
    - name: /tmp/mac_shortcut.sh
    - source: salt://phpstorm/files/mac_shortcut.sh
    - mode: 755
    - template: jinja
    - context:
      appname: {{ phpstorm.pkg.name }}
      edition: {{ '' if 'edition' not in phpstorm else phpstorm.edition }}
      user: {{ phpstorm.identity.user }}
      homes: {{ phpstorm.dir.homes }}
  cmd.run:
    - name: /tmp/mac_shortcut.sh
    - runas: {{ phpstorm.identity.user }}
    - require:
      - file: phpstorm-macos-app-install-macpackage

    {%- else %}

phpstorm-macos-app-install-unavailable:
  test.show_notification:
    - text: |
        The phpstorm macpackage is only available on MacOS

    {%- endif %}
