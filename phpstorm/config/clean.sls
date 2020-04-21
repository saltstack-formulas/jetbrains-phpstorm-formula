# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import phpstorm with context %}

   {%- if phpstorm.pkg.use_upstream_macapp %}
       {%- set sls_package_clean = tplroot ~ '.macapp.clean' %}
   {%- else %}
       {%- set sls_package_clean = tplroot ~ '.archive.clean' %}
   {%- endif %}

include:
  - {{ sls_package_clean }}

phpstorm-config-clean-file-absent:
  file.absent:
    - names:
      - /tmp/dummy_list_item
               {%- if phpstorm.config_file and phpstorm.config %}
      - {{ phpstorm.config_file }}
               {%- endif %}
               {%- if phpstorm.environ_file %}
      - {{ phpstorm.environ_file }}
               {%- endif %}
               {%- if grains.kernel|lower == 'linux' %}
      - {{ phpstorm.linux.desktop_file }}
               {%- elif grains.os == 'MacOS' %}
      - {{ phpstorm.dir.homes }}/{{ phpstorm.identity.user }}/Desktop/{{ phpstorm.pkg.name }}{{ ' %sE'|format(phpstorm.edition) if phpstorm.edition else '' }}  # noqa 204
               {%- endif %}
    - require:
      - sls: {{ sls_package_clean }}
