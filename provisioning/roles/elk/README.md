# Ansible role - ELK stack

This role serves for automatic installation of **Elasticsearch**, **Logstash** and **Kibana** on debian-based systems.

## Requirements

This role requires root access, so you either need to specify `become` directive as a global or while invoking the role.

```yml
become: yes
```

## Role paramaters

All parameters are optional.

* `elk_elasticsearch_configuration` - List of Elasticsearch configurations (elasticsearch.yml), where each one consists of following attributes:
    * `key` - Attribute key.
    * `value` - Attribute value.
    * `state` - Either `present` or `absent` value (default: present).
* `elk_elasticsearch_log4j2_configuration` - List of Log4j2 configurations (log4j2.properties), where each one consists of following attributes:
    * `key` - Attribute key.
    * `value` - Attribute value.
    * `state` - Either `present` or `absent` value (default: present).
* `elk_elasticsearch_jvm_heap_min` - The minimum size of Java virtual machine heap sets **-Xms** JVM option (default: 512m).
* `elk_elasticsearch_jvm_heap_min` - The maximum size of Java virtual machine heap sets **-Xmx** JVM option (default: 1g).
* `elk_kibana_configuration` - List of Kibana configurations (kibana.yml), where each one consists of following attributes:
    * `key` - Attribute key.
    * `value` - Attribute value.
    * `state` - Either `present` or `absent` value (default: present).
* `elk_logstash_configuration_files` - List of paths to Logstash configuration files, either on local or remote machine (default: []).
* `elk_logstash_pattern_files` - List of paths to Logstash pattern files, either on local or remote machine (default: []).
* `elk_logstash_plugins` - List of Logstash plugin names (default: []).

## Example

Example of the simplest ELK stack installation.

```yml
roles:
    - role: elk
      become: yes
```

And more complex one.

```yml
roles:
    - role: elk
      elk_elasticsearch_configuration:
        - key: network.host
          value: 0.0.0.0
      elk_elasticsearch_jvm_heap_max: 4g
      elk_kibana_configuration:
        - key: server.host
          value: 0.0.0.0
        - key: server.port
          value: 5601
        - key: elasticsearch.preserverHost
          value: true
        - key: elasticsearch.requestTimeout
          value: 300000
        - key: elasticsearch.url
          value: 'http://localhost:9200'
      become: yes
```