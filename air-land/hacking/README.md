Hacking
============

针对CentOS和CoreOS做的优化。
此部分优化可以理解为暂未封装到image的beta版本。



依赖更新
--------
```
ansible-galaxy install -r roles.yml  -p ./roles         # 首次安装
ansible-galaxy install -f -r roles.yml  -p ./roles      # 强制更新
```


注意事项
--------
shadow 类型机器应该早于 teamwork 的执行



完整顺序
--------
```
ansible-playbook -i hosts-group/btb-inc -t shadow  playbook.yml --ask-pass # 重置端口机器
..... 此处代码略 # 更新shadow已生效的端口为指定端口

# 切换 seed-teamwork
cd ~/Codes/btb/seed-teamwork/ && ansible-playbook -i hosts-group/btb-inc playbook.yml --ask-pass  # 还没有配置全局公钥的机器

ansible-playbook -i hosts-group/btb-inc -t reset  playbook.yml # 修改简单密码
ansible-playbook -i hosts-group/btb-inc -t centos  playbook.yml # Hacking Centos
ansible-playbook -i hosts-group/btb-inc -t hack  playbook.yml # Hacking Kernel
```

# 个人机器资源备忘
```
ansible-playbook -i hosts-group/my-lab -t hack  playbook.yml # Hacking Kernel

```

