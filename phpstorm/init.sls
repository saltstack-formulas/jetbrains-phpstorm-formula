{% from "phpstorm/map.jinja" import phpstorm with context %}

# Cleanup first
phpstorm-remove-prev-archive:
  file.absent:
    - name: '{{ phpstorm.tmpdir }}/{{ phpstorm.dl.archive_name }}'
    - require_in:
      - phpstorm-extract-dirs

phpstorm-extract-dirs:
  file.directory:
    - names:
      - '{{ phpstorm.tmpdir }}'
{% if grains.os not in ('MacOS', 'Windows',) %}
      - '{{ phpstorm.jetbrains.realhome }}'
    - user: root
    - group: root
    - mode: 755
{% endif %}
    - makedirs: True
    - clean: True
    - require_in:
      - phpstorm-download-archive

phpstorm-download-archive:
  cmd.run:
    - name: curl {{ phpstorm.dl.opts }} -o '{{ phpstorm.tmpdir }}/{{ phpstorm.dl.archive_name }}' {{ phpstorm.dl.source_url }}
      {% if grains['saltversioninfo'] >= [2017, 7, 0] %}
    - retry:
        attempts: {{ phpstorm.dl.retries }}
        interval: {{ phpstorm.dl.interval }}
      {% endif %}

{%- if phpstorm.dl.src_hashsum %}
   # Check local archive using hashstring for older Salt / MacOS.
   # (see https://github.com/saltstack/salt/pull/41914).
  {%- if grains['saltversioninfo'] <= [2016, 11, 6] or grains.os in ('MacOS',) %}
phpstorm-check-archive-hash:
   module.run:
     - name: file.check_hash
     - path: '{{ phpstorm.tmpdir }}/{{ phpstorm.dl.archive_name }}'
     - file_hash: {{ phpstorm.dl.src_hashsum }}
     - onchanges:
       - cmd: phpstorm-download-archive
     - require_in:
       - archive: phpstorm-package-install
  {%- endif %}
{%- endif %}

phpstorm-package-install:
{% if grains.os == 'MacOS' %}
  macpackage.installed:
    - name: '{{ phpstorm.tmpdir }}/{{ phpstorm.dl.archive_name }}'
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
{% else %}
  # Linux
  archive.extracted:
    - source: 'file://{{ phpstorm.tmpdir }}/{{ phpstorm.dl.archive_name }}'
    - name: '{{ phpstorm.jetbrains.realhome }}'
    - archive_format: {{ phpstorm.dl.archive_type }}
       {% if grains['saltversioninfo'] < [2016, 11, 0] %}
    - tar_options: {{ phpstorm.dl.unpack_opts }}
    - if_missing: '{{ phpstorm.jetbrains.realcmd }}'
       {% else %}
    - options: {{ phpstorm.dl.unpack_opts }}
       {% endif %}
       {% if grains['saltversioninfo'] >= [2016, 11, 0] %}
    - enforce_toplevel: False
       {% endif %}
       {%- if phpstorm.dl.src_hashurl and grains['saltversioninfo'] > [2016, 11, 6] %}
    - source_hash: {{ phpstorm.dl.src_hashurl }}
       {%- endif %}
{% endif %} 
    - onchanges:
      - cmd: phpstorm-download-archive
    - require_in:
      - phpstorm-remove-archive

phpstorm-remove-archive:
  file.absent:
    - name: '{{ phpstorm.tmpdir }}'
    - onchanges:
{%- if grains.os in ('Windows',) %}
      - pkg: phpstorm-package-install
{%- elif grains.os in ('MacOS',) %}
      - macpackage: phpstorm-package-install
{% else %}
      #Unix
      - archive: phpstorm-package-install

{% endif %}
