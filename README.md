# Déploiement Ansible de Projectsend

Il s'agit d'un projet étudiant de déploiement Ansible de l'outil Projectsend à l'aide du role Ansistrano.

Ce projet a été réalisé dans le cadre de la licence pro DEVOPS à l'IUT LYON 1 dans la promotion 2021/2022.

## conditions de test
- VM openstack
    - OS : Ubuntu-20.04
    - Volume: 8GO
    - Gabarit: tiny.m2 | 1 VCPUS | RAM 1 GO| Total Disque 5GO | Disque Racine 5 GO | Disque Éphémère 5 GO

## auteur

AMINE ABOUSALHAM - p1908955

Etudiant en licence pro DEVOPS

## Partie serveur
Le playbook `server.yml` se charge du déploiement serveur en installant tous les outils nécessaires à ProjectSend

Projectsend est un project codé en `php` hébérgé dans un serveur `nginx`.
Il utilise une base de données `Mariadb`.

Les roles `php`, `nginx` et `Mariadb` ne devaient pas provenir de la communauté (consigne du projet).

## Partie applicatif
Le playbook `app.yml` se charge quant à lui du déploiement applicatif de ProjectSend.

Pour cela, j'ai utilisé le role `Ansistrano` pour permettre du `atomic deployment`.

> **Atomic deployment** – Make updates available only when they are complete and totally in place.

### Architecture de déploiement

```
-- /var/www/html/pre_prod/projectsend
|-- current -> /var/www/html/pre_prod/projectsend/releases/20200512131539
|-- releases
|   |-- 20200512131539
|   |-- 20200509150741
|   |-- 20200509145325
|-- shared
```
- Chaque environnement dispose de sa propre base de données mariadb avec un utilisateur et un mot de passe différent.
    - Ces identifiants sont situés dans pre_prod/vault.yml & prod/vault.yml

Le dossier upload dans projectSend est partagé (shared) entre les différentes versions de déploiement.


## utilisation

Le playbook est exécuté sur deux VM openstack du réseau de l'IUT qui correspondent respectivement aux environnements de pré-production et de production.

La clé .pem est fournie au professeur pour lancer les playbooks sur deux nouvelles VM Openstack.

Les commandes Ansible à passer sont dans le Makefile.

Pour évaluer le projet, le professeur crée en local un nouveau fichier .vaultPawd contenant le mot de passe `devops` qui décrypte les fichiers vault lors de l'exécution.

Pour faciliter l'évalution du projet, le mot de passe vault est donnée ici.
En temps normal, il ne doit jamais être partagé sur le repo git.


Une fois l'outil déployé, il est accessible en HTTP sur l'adresse ip de la machine sur tout le réseau de l'IUT :

http://adresse_machine/install/index.php

## listes des roles

- nginx
- php
- mariadb

- ansistrano.deploy
- ansistrano.rollback


