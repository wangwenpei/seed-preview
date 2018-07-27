Air Land
=============

用于在K8s之外的环境部署。
主要针对：

- HelloWorld工具
- Arm芯片机器


依赖更新
--------
```
ansible-galaxy install -r roles.yml  -p ./roles         # 首次安装
ansible-galaxy install -f -r roles.yml  -p ./roles      # 强制更新
```


已知Bug
----------

- [在DO中出现挂起](https://github.com/wangwenpei/seed/issues/1)

