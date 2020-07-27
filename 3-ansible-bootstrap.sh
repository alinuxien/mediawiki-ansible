ansible -i inventaire.ini -m user -a 'name=user-ansible password=$6$secretsalt$iccwgsnqtsfbC2fJqVuHt5FPZKi3FX2ryqttcnscv5NnkvOaFMSdfoRH4QlihXQS4XTW3WSh1WyMvh0ROerBS/' --user root --extra-vars "ansible_ssh_pass=alinuxien" all
ansible -i inventaire.ini -m user -a 'name=user-ansible groups=sudo append=yes ' --user root --extra-vars "ansible_ssh_pass=alinuxien" all

