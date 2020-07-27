ansible -i inventaire.ini -m authorized_key -a 'user=user-ansible state=present key="{{ lookup("file", "/vagrant/.ssh/id_ecdsa.pub") }}"' --user user-ansible --become --extra-vars "ansible_ssh_pass=alinuxien ansible_become_pass=alinuxien" all

