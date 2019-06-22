#!/bin/bash

export SCRIPT_PATH=$(realpath $0)
cd $(dirname $SCRIPT_PATH)
$(which ansible-playbook) ./playbooks/initial.yml --ask-become-pass