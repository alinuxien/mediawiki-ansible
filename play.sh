ansible-playbook -i inventaire.ini --user user-ansible --become --extra-vars "ansible_ssh_pass=alinuxien ansible_become_pass=alinuxien" install-apache.yml
ansible-playbook -i inventaire.ini --user user-ansible --become --extra-vars "ansible_ssh_pass=alinuxien ansible_become_pass=alinuxien" install-mariadb.yml
ansible-playbook -i inventaire.ini --user user-ansible --become --extra-vars "ansible_ssh_pass=alinuxien ansible_become_pass=alinuxien" --ask-vault-pass install-mediawiki.yml
