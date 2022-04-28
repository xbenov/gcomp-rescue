# Ansible role - MySQL database server #

This role serves for automatic installation of MySQL database server on debian-based systems.

The role will perform basic __secure__ MySQL installation.

## Requirements

This role requires root access, so you either need to specify `become` directive as a global or while invoking the role.

```yml
become: yes
```

## Role paramaters

optional

* `mysql_root_password` - The password of user root (default `toor`).
* `mysql_user_name` - The name of the user account.
* `mysql_user_password` - The password of user `mysql_user_name`.
* `mysql_user_encrypted` - Boolean value if password is encrypted or not (default `no`).
* `mysql_user_privileges` - The list of user `mysql_user_name` privileges.
* `mysql_database_name` - The name of the database.
* `mysql_database_scripts` - The list of SQL scripts that will be executed on database `mysql_database_name` right after creation.

## Example

Example of the simplest Mysql installation.

```yml
roles:
    - role: mysql
      become: yes
```

Mysql installation, that creates user `my_user` with database `my_db`, initializes `my_db` using SQL script `tables.sql` and grant user `my_user` privileges to database `my_db`.

```yml
roles:
    - role: mysql
      mysql_user_name: my_user
      mysql_user_password: my_password
      mysql_user_privileges:
          - my_db.*:ALL
      mysql_database_name: my_db
      mysql_database_scripts:
          - /tmp/tables.sql
      become: yes
```