"""
=============
启动项
=============
"""
import json
import os
import tempfile

from fabric.api import *


def get_proxy_qingcloud():
    """获取代理IP"""

    terrafiles = './terrafiles-%s' % 'qingcloud'

    with open('%s/terraform.tfstate' % terrafiles) as jp:
        data = json.load(jp)
        try:
            proxy_ip = \
                data['modules'][0]['resources']['qingcloud_eip.init'][
                    'primary'][
                    'attributes']['addr']
        except (KeyError, ValueError):
            abort("Invalid terraform data...")
            pass

    return proxy_ip


def get_proxy_digitalocean():
    """获取代理IP"""

    terrafiles = './terrafiles-%s' % 'digitalocean'

    with open('%s/terraform.tfstate' % terrafiles) as jp:
        data = json.load(jp)
        try:
            proxy_ip = \
                data['modules'][0]['resources']['digitalocean_droplet.ss'][
                    'primary'][
                    'attributes']['ipv4_address']
        except (KeyError, ValueError):
            abort("Invalid terraform data...")
            pass

    # return ' '.join([proxy_ip, 'ansible_user=%s' % 'core'])
    return proxy_ip



@task
def apply(cip="digitalocean", reboot='no', update_os='no'):
    """
    一键安装
    :return:
    """

    terrafiles = './terrafiles-%s' % cip

    with lcd(terrafiles):
        local('terraform init')
        if cip == "qingcloud":
            local('terraform apply'
                  ' -var "access_key=`echo $QINGCLOUD_ACCESS_KEY`"'
                  ' -var "secret_key=`echo  $QINGCLOUD_ACCESS_SECRET`"'
                  ' -auto-approve')
        elif cip == "digitalocean":
            local('terraform apply'
                  ' -var "do_token=`echo $DO_TOKEN`"'
                  ' -auto-approve')
            pass
        pass

    proxy_ip = globals()['get_proxy_' + cip]()

    with tempfile.NamedTemporaryFile(mode='w') as fp:
        fp.write(proxy_ip)
        fp.flush()

        with lcd('./hacking'):
            local('ansible-playbook'
                  ' -i %(host_file)s playbook.yml'
                  ' -e update_os=%(update_os)s'
                  ' -e digitalocean=%(digitalocean)s'
                  ' -e reboot=%(reboot)s' % {
                      'host_file': fp.name,
                      'reboot': reboot,
                      'update_os': update_os,
                      'digitalocean': 'yes' if cip == 'digitalocean' else 'no'
                  })
            pass
        pass

    pass


@task
def service(sv, status='started', cip="digitalocean"):
    """部署服务"""

    proxy_ip = globals()['get_proxy_' + cip]()

    with tempfile.NamedTemporaryFile(mode='w') as fp:
        fp.write(proxy_ip)
        fp.flush()

        with lcd('./services'):
            local(
                'ansible-playbook -t %(service)s'
                ' -i %(host_file)s playbook.yml'
                ' -e air_land_template_root=%(root)s/services/templates'
                ' -e air_land_service_status=%(status)s '
                ' -e air_land_timer_status=%(status)s ' % {
                    'host_file': fp.name,
                    'service': sv,
                    'root': os.getcwd(),
                    'status': status
                })
            pass
        pass

    pass


@task
def destroy(cip):
    """
    一键删除
    :return:
    """

    terrafiles = './terrafiles-%s' % cip

    with lcd(terrafiles):
        if cip == "qingcloud":
            local('terraform destroy'
                  ' -var "access_key=`echo $QINGCLOUD_ACCESS_KEY`"'
                  ' -var "secret_key=`echo  $QINGCLOUD_ACCESS_SECRET`"'
                  ' -auto-approve')
        elif cip == "digitalocean":
            local('terraform destroy'
                  ' -var "do_token=`echo $DO_TOKEN`"'
                  ' -auto-approve')
        pass
    pass
