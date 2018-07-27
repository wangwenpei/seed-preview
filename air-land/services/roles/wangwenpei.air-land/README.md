Ansible-Air-Land
========================================================================================

Deploy docker use docker-compose and manage by systemd.


Install
-------

```
ansible-galaxy install wangwenpei.air-land
```

Config
----------
ansible.cfg

```
filter_plugins  = roles/wangwenpei.air-land/plugins/filter
```


Role Variables
--------------

```
air_land_project: "project"
air_land_template_root: "<template-root>"
air_land_active_services:
  - services-name-1
  - services-name-2
docker_compose_interpreter: "/usr/bin/docker-compose"

```

Requirements
------------------

- `$templates/air-lands` must be existed.


Example Playbook
----------------

```
- name: Hello World
  hosts: all
  gather_facts: True
  environment:
        PATH: "/opt/local/bin:/usr/bin:/usr/local/bin:/usr/sbin:/usr/local/sbin"
  vars:
    ansible_python_interpreter: "/usr/bin/env python"
    air_land_project: "hello-world"
    air_land_template_root: "/tmp/templates/air-lands"
    air_land_active_services:
      - hello-world

  roles:
    - wangwenpei.air-land

  tags: "hello-world"
```


License
-------

GPLv3

Author Information
------------------

Author: wangwenpei
