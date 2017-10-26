{% from "phpstorm/map.jinja" import phpstorm with context %}

{% if grains.os not in ('MacOS', 'Windows') %}

  {% if grains.os_family not in ('Arch') %}

# Add pyCharmhome to alternatives system
phpstorm-home-alt-install:
  alternatives.install:
    - name: phpstormhome
    - link: {{ phpstorm.symhome }}
    - path: {{ phpstorm.alt.realhome }}
    - priority: {{ phpstorm.alt.priority }}

phpstorm-home-alt-set:
  alternatives.set:
    - name: phpstormhome
    - path: {{ phpstorm.alt.realhome }}
    - onchanges:
      - alternatives: phpstorm-home-alt-install

# Add to alternatives system
phpstorm-alt-install:
  alternatives.install:
    - name: phpstorm
    - link: {{ phpstorm.symlink }}
    - path: {{ phpstorm.alt.realcmd }}
    - priority: {{ phpstorm.alt.priority }}
    - require:
      - alternatives: phpstorm-home-alt-install
      - alternatives: phpstorm-home-alt-set

phpstorm-alt-set:
  alternatives.set:
    - name: phpstorm
    - path: {{ phpstorm.alt.realcmd }}
    - onchanges:
      - alternatives: phpstorm-alt-install

  {% endif %}

{% endif %}
