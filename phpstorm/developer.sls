{% from "phpstorm/map.jinja" import phpstorm with context %}

{% if phpstorm.prefs.user not in (None, 'undefined_user', 'undefined', '',) %}

  {% if grains.os == 'MacOS' %}
phpstorm-desktop-shortcut-clean:
  file.absent:
    - name: '{{ phpstorm.homes }}/{{ phpstorm.prefs.user }}/Desktop/PhpStorm'
    - require_in:
      - file: phpstorm-desktop-shortcut-add
  {% endif %}

phpstorm-desktop-shortcut-add:
  {% if grains.os == 'MacOS' %}
  file.managed:
    - name: /tmp/mac_shortcut.sh
    - source: salt://phpstorm/files/mac_shortcut.sh
    - mode: 755
    - template: jinja
    - context:
      user: {{ phpstorm.prefs.user }}
      homes: {{ phpstorm.homes }}
      edition: {{ phpstorm.jetbrains.edition }}
  cmd.run:
    - name: /tmp/mac_shortcut.sh {{ phpstorm.jetbrains.edition }}
    - runas: {{ phpstorm.prefs.user }}
    - require:
      - file: phpstorm-desktop-shortcut-add
   {% else %}
   #Linux
  file.managed:
    - source: salt://phpstorm/files/phpstorm.desktop
    - name: {{ phpstorm.homes }}/{{ phpstorm.prefs.user }}/Desktop/phpstorm{{ phpstorm.jetbrains.edition }}.desktop
    - user: {{ phpstorm.prefs.user }}
    - makedirs: True
      {% if salt['grains.get']('os_family') in ('Suse',) %} 
    - group: users
      {% else %}
    - group: {{ phpstorm.prefs.user }}
      {% endif %}
    - mode: 644
    - force: True
    - template: jinja
    - onlyif: test -f {{ phpstorm.jetbrains.realcmd }}
    - context:
      home: {{ phpstorm.jetbrains.realhome }}
      command: {{ phpstorm.command }}
   {% endif %}


  {% if phpstorm.prefs.jarurl or phpstorm.prefs.jardir %}

phpstorm-prefs-importfile:
   {% if phpstorm.prefs.jardir %}
  file.managed:
    - onlyif: test -f {{ phpstorm.prefs.jardir }}/{{ phpstorm.prefs.jarfile }}
    - name: {{ phpstorm.homes }}/{{ phpstorm.prefs.user }}/{{ phpstorm.prefs.jarfile }}
    - source: {{ phpstorm.prefs.jardir }}/{{ phpstorm.prefs.jarfile }}
    - user: {{ phpstorm.prefs.user }}
    - makedirs: True
        {% if grains.os_family in ('Suse',) %}
    - group: users
        {% elif grains.os not in ('MacOS',) %}
        #inherit Darwin ownership
    - group: {{ phpstorm.prefs.user }}
        {% endif %}
    - if_missing: {{ phpstorm.homes }}/{{ phpstorm.prefs.user }}/{{ phpstorm.prefs.jarfile }}
   {% else %}
  cmd.run:
    - name: curl -o {{phpstorm.homes}}/{{phpstorm.prefs.user}}/{{phpstorm.prefs.jarfile}} {{phpstorm.prefs.jarurl}}
    - runas: {{ phpstorm.prefs.user }}
    - if_missing: {{ phpstorm.homes }}/{{ phpstorm.prefs.user }}/{{ phpstorm.prefs.jarfile }}
   {% endif %}

  {% endif %}

{% endif %}

