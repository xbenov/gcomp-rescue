# Ansible role - Apache2 webserver #

This role serves for automatic installation of Apache 2 webserver on debian-based systems.

The role will install basic Apache 2 installation and will disable the default sites.

## Requirements

This role requires root access, so you either need to specify `become` directive as a global or while invoking the role.

```yml
become: yes
```

## Role paramaters

All parameters are optional.

* `apache_virtualhost` - Virtualhost configuration file or Jinja2 template of the file.
* `apache_packages` - List of additional apache2 packages, that needs to be installed. Like modules or plugins.
* `apache_enable_mods` - List of modules, that will be enabled.
* `apache_listen_port` - Listening port of virtualhost `apache_virtualhost`.


## Example

Example of simple apache2 installation.

```yml
roles:
    - role: apache
      apache_virtualhost: virtualhost.conf.j2
      apache_packages:
          - libapache2-mod-wsgi-py3
      apache_enable_mods:
          - wsgi
          - rewrite
      apache_listen_port: 8080
      become: yes
```
