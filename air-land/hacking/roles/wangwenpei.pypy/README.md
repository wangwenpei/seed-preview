Ansible-Pypy ![](https://secure.travis-ci.org/wangwenpei/ansible-pypy.png?branch=master)
========================================================================================

Install Portable PyPy for Linux.
This Role is inspiring from [defunctzombie.coreos-bootstrap](https://github.com/defunctzombie/ansible-coreos-bootstrap)

Install
-------

```
ansible-galaxy install wangwenpei.pypy
```

Role Variables
--------------

```
pypy_bin_path: /opt/local/bin
pypy_home: /opt/local/portable-pypy
pypy_version: 3.5-5.10.1
pypy_arch: linux_x86_64-portable
pypy_mirror: https://bitbucket.org/squeaky/portable-pypy/downloads
pypy_wget_extra:
pypy_bz2_md5sum: b7a900da2dd2af05131b0560698c20ec

```

Note
----

Currently, we only support user install python3.5+, python2.7+ should be work.
Because `get-pip.py` is quite different for other python version.



Example Playbook
----------------

For target machine

```
    - hosts: servers
      vars:
        pypy_wget_extra: --no-check-certificate
      roles:
        - wangwenpei.pypy
```


License
-------

MIT

Author Information
------------------

Author: wangwenpei
