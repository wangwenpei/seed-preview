"""
=====================================================
wrapper for os.path.basename(os.path.rsplit('/',1))
=====================================================
"""
from __future__ import (absolute_import, division, print_function)

import os

__metaclass__ = type

ANSIBLE_METADATA = {
    'metadata_version': '1.1',
    'status': ['preview'],
    'supported_by': 'stormxx'
}


def parentname(value):
    return os.path.basename(str(value).rsplit('/', 1)[0])



# ---- Ansible filters ----
class FilterModule(object):
    """ Parent name filter """

    def filters(self):
        return {
            'parentname': parentname
        }
