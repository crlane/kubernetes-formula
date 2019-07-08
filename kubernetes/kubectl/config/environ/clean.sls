# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_clean = tplroot ~ '.kubectl.binary.clean' %}
{%- set sls_package_clean = tplroot ~ '.kubectl.package.clean' %}
{%- set sls_source_clean = tplroot ~ '.kubectl.source.clean' %}

include:
  - {{ sls_package_clean }}
  - {{ sls_source_clean }}
  - {{ sls_binary_clean }}

k8s-kubectl-config-environ-clean-file-absent:
  file.absent:
    - name: {{ k8s.kubectl.environ_file }}
    - require:
      - sls: {{ sls_package_clean }}
      - sls: {{ sls_source_clean }}
      - sls: {{ sls_binary_clean }}
