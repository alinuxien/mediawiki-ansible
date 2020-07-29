# Bienvenue sur mon projet mediawiki installé par Ansible !
Il s'agit d'un exercice de cours Ansible, réalisé en Juillet 2020, dans le cadre de ma formation "Expert DevOps" chez OpenClassRooms.
## Ca fait quoi ?
Ca réalise l'installation et la configuration de base de mediawiki ( un gestionnaire de wiki à la Wikipedia ), à l'aide de Ansible, sur une infrastructure virtuelle, et accessible depuis la machine hôte.
## TRES IMPORTANT
CE CONTENU A ETE FAIT POUR EXERCICE ANSIBLE ET N'EST PAS SECURISE CORRECTEMENT, IL NE DOIT DONC PAS ETRE UTILISE EN PRODUCTION MAIS POUR TEST UNIQUEMENT
## Ca ressemble à quoi ?
![Aperçu de l'architecture](https://github.com/alinuxien/mediawiki-ansible/raw/master/layout.png)
## Contenu ?
Un Vagrantfile pour démarrer une VM paramétrée avec redirection des ports.  
Un script 0-vagrant-bootstrap.sh qui va préparer la VM avec tous les outils nécessaires, et qui sera appelé par le Vagrantfile.  
Un Dockerfile pour créer une image Docker adaptée pour les nodes Ansible, notamment Python.  
Un script 1-builddockerimage.sh pour lancer le build de l'image ( à personnaliser, nous verrons ça ).  
Un script 2-rundockernodes.sh pour lancer le run des 2 nodes.  
Un script 3-ansible-bootstrap.sh ( personnalisable, nou verrons ça aussi )  
Le dossier roles qui contient les roles Ansible.  
Les 3 playbooks install-apache.yml, install-apache.yml, install-mediawiki.yml, dont le nom est explicite, et enfin le script play.sh qui lance 3 playbooks.  
D'autres fichiers et scripts, qui ne fonctionne pas comme je voudrais, mais dont le nom est explicité au cas où quelqu'un voudrait les utiliser.  
## J'ai besoin de quoi ?
De [Virtual Box](https://www.virtualbox.org/) et de [Vagrant](https://www.vagrantup.com/downloads) installés sur la machine hôte, et peut-être un café parce que ça peut prendre 30 mns ou plus selon votre connexion et votre machine.
## Comment ça s'utilise ?
Après avoir récupéré tous les fichiers dans un dossier de travail ( git clone https://github.com/alinuxien/mediawiki-ansible.git ), on va exécuter, dans un terminal positionné dans ce dossier, les commandes suivantes :  
vagrant up  
vagrant ssh  
cd /vagrant  
Personnalisez le mot de passe root/ssh des futurs nodes ( par défaut alinuxien ), en éditant le fichier ./1-builddockerimage.sh avec vim, selon la syntaxe "docker build -t nodes --build-arg ROOT_PASS=mon-mot-de-passe . " ( ne pas oublier le point à la fin )  
Ensuite, on reprend l'exécution de :  
./1-builddockerimage.sh  
./2-rundockernodes.sh  
Connectez vous en ssh aux 2 nodes, pour ajouter le fingerprint des nodes sur la VM Ansible :   
ssh root@http1 ( puis yes, puis le pass personnalisé ou alinuxien ). Puis vous quittez le ssh ( ctrl-d ).  
ssh root@bdd1 ( puis yes, puis le pass personnalisé ou alinuxien ). Puis vous quittez le ssh ( ctrl-d ).  
Vous pouvez personnaliser le mot de passe du futur user-ansible sur les 2 nodes, en préparant votre mot de passe personnalisé chiffré avec la commande :  
ansible -i inventaire.ini -m debug -a "msg={{ 'alinuxien' | password_hash('sha512', 'secretsalt') }}" localhost   
( remplacez 'alinuxien' bien sûr )  
Et vous pourrez mettre le résultat de cette commande dans le script 3-ansible-bootstrap.sh.  
Ensuite on exécute :  
3-ansible-bootstrap.sh  
Ensuite, pour information, dans le fichier roles/mediawiki/commun/defaults/main.yml se trouvent 2 mots de passe chiffrés qui ont été générés par les commandes :   
ansible-vault 'foobar' --name 'mediawiki_db_password'  
ansible-vault encrypt_string 'foobar' --name 'mediawiki_admin_password'  
avec le mot de passe Ansible2019  
Vous pouvez personnaliser ce mot de passe et modifier le fichier roles/mediawiki/commun/defaults/main.yml, ou laisser tel quel pour garder un mot de passe foobar  
Enfin, on lance l'installation complète Apache, PHP, Mysql, mediawiki, et les configurations associées, avec la commande :   
./play.sh  ( je rappelle que le mot de passe demandé sera par défaut Ansible2019 )
## Ca a marché ? Il suffit de lancer son navigateur internet préféré sur la machine hôte, à l'adresse :   
[http://localhost:8000/mediawiki](http://localhost:8000/mediawiki)
# Et après ?
Les mots de passe ssh des nodes aurait pu être passé en variable de script, et réutilisés pour positionner les pass ansible ( ansible_ssh_pass et ansible_become_pass ) en variable d'environnement, automatisé par le Dockerfile, se qui permettrait de ne pas inscrire en dur le mot de passe, à aucun niveau.  
Les variables de user Ansible auraient pu être passées dans l'inventaire, pour ne pas les trainer dans tous les commandes...  
Dans la même idée, on pourrait augmenter la sécurité de la BD en n'autorisant les connexions entrantes sur le serveur que depuis http1, l'utilisateur mediawiki de la BD autorisé uniquement depuis http1 et sur la base mediawiki...  
Enfin, les scripts concernant la générération de clés SSH et leur copie vers les nodes fonctionnent, mais seulement quelques instants. Cela reste à travailler.  
Je manque de temps pour le moment pour continuer cela, mais je suis ouvert aux propositions...  

