ansible -i inventaire.ini -m authorized_key -a 'user=user-ansible state=present key="{{ lookup("file", "/vagrant/.ssh/id_ecdsa.pub") }}"' --user user-ansible --ask-pass --become --ask-become-pass all

