## Description
An [Ansible](http://www.ansible.com) role to install Java8 JDK. This role works on Debian, Ubuntu and RedHat (CentOS) operating systems. Installation from source is also supported.

## Requirements

This role requires root access, so you either need to specify `become` directive as a global or while invoking the role.

```yml
become: yes
```

## Role Variables

- **java_source**: flag to enable installation from source files instead from a repository.
- **debug**: flag to enable verbose mode within the role.
- **java_set_as_default**: flag to set the Java version installed by this role as default (default= `yes`).

## Example Playbook

```yaml
# Generic with debug
- hosts: myServer
  become: yes
  roles:
  - role: java-8
    debug: yes

# Enable debug, install from source
- hosts: myServer
  become: yes
  roles:
  - role: java-8
    debug: yes
    java_source: yes
```
