ansible -i inventaire.ini -m user -a 'name=user-ansible groups=sudo append=yes ' --user user-ansible --become --extra-vars "ansible_ssh_pass=alinuxien ansible_become_pass=alinuxien"  all

