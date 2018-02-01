{% from "phpstorm/map.jinja" import phpstorm with context %}

{% if phpstorm.prefs.user %}

phpstorm-desktop-shortcut-clean:
  file.absent:
    - name: '{{ phpstorm.homes }}/{{ phpstorm.prefs.user }}/Desktop/PhpStorm'
    - require_in:
      - file: phpstorm-desktop-shortcut-add
    - onlyif: test "`uname`" = "Darwin"

phpstorm-desktop-shortcut-add:
  file.managed:
    - name: /tmp/mac_shortcut.sh
    - source: salt://phpstorm/files/mac_shortcut.sh
    - mode: 755
    - template: jinja
    - context:
      user: {{ phpstorm.prefs.user }}
      homes: {{ phpstorm.homes }}
      edition: {{ phpstorm.jetbrains.edition }}
    - onlyif: test "`uname`" = "Darwin"
  cmd.run:
    - name: /tmp/mac_shortcut.sh {{ phpstorm.jetbrains.edition }}
    - runas: {{ phpstorm.prefs.user }}
    - require:
      - file: phpstorm-desktop-shortcut-add
    - require_in:
      - phpstorm-desktop-shortcut-install
    - onlyif: test "`uname`" = "Darwin"

phpstorm-desktop-shortcut-install:
  file.managed:
    - source: salt://phpstorm/files/phpstorm.desktop
    - name: {{ phpstorm.homes }}/{{ phpstorm.prefs.user }}/Desktop/phpstorm{{ phpstorm.jetbrains.edition }}.desktop
    - makedirs: True
    - user: {{ phpstorm.prefs.user }}
       {% if phpstorm.prefs.group and grains.os not in ('MacOS',) %}
    - group: {{ phpstorm.prefs.group }}
       {% endif %}
    - mode: 644
    - force: True
    - template: jinja
    - onlyif: test -f {{ phpstorm.jetbrains.realcmd }}
    - context:
      home: {{ phpstorm.jetbrains.realhome }}
      command: {{ phpstorm.command }}


  {% if phpstorm.prefs.jarurl or phpstorm.prefs.jardir %}

phpstorm-prefs-importfile:
  file.managed:
    - onlyif: test -f {{ phpstorm.prefs.jardir }}/{{ phpstorm.prefs.jarfile }}
    - name: {{ phpstorm.homes }}/{{ phpstorm.prefs.user }}/{{ phpstorm.prefs.jarfile }}
    - source: {{ phpstorm.prefs.jardir }}/{{ phpstorm.prefs.jarfile }}
    - makedirs: True
    - user: {{ phpstorm.prefs.user }}
       {% if phpstorm.prefs.group and grains.os not in ('MacOS',) %}
    - group: {{ phpstorm.prefs.group }}
       {% endif %}
    - if_missing: {{ phpstorm.homes }}/{{ phpstorm.prefs.user }}/{{ phpstorm.prefs.jarfile }}
  cmd.run:
    - unless: test -f {{ phpstorm.prefs.jardir }}/{{ phpstorm.prefs.jarfile }}
    - name: curl -o {{phpstorm.homes}}/{{phpstorm.prefs.user}}/{{phpstorm.prefs.jarfile}} {{phpstorm.prefs.jarurl}}
    - runas: {{ phpstorm.prefs.user }}
    - if_missing: {{ phpstorm.homes }}/{{ phpstorm.prefs.user }}/{{ phpstorm.prefs.jarfile }}
  {% endif %}


{% endif %}

