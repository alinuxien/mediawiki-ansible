ansible -i inventaire.ini -m user -a 'name=user-ansible groups=sudo append=yes ' --user user-ansible --ask-pass --become --ask-become-pass all

