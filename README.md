# NodeJsFinal

#### Ce projet est une application de partage de fichiers. Elle permet aux utilisateurs de s'inscrire, de télécharger des fichiers avec un quota maximal de 2 Go par utilisateur, de gérer leurs fichiers (télécharger, supprimer), et de générer des liens de partage temporaires. Le projet est entièrement conteneurisé pour une facilité de déploiement et inclut une interface utilisateur conviviale pour une expérience optimale.

## Fonctionnalités

- **Gestion des Utilisateurs** : Inscription, connexion et authentification sécurisées avec JWT.
- **Téléchargement et Gestion de Fichiers** : Téléchargement, suppression de fichiers, avec suivi du quota d'espace utilisé.
- **Liens de Partage Temporaires** : Génération de liens de partage valables pendant 24 heures.
- **Quota par Utilisateur** : Quota de 2 Go par utilisateur, affiché et mis à jour dynamiquement.
- **Déploiement Facile** : Conteneurisation complète avec Docker et Docker Compose.

## Prérequis

- Docker et Docker Compose installés sur votre machine.

## Déploiement

Clonez le projet :

```bash
git clone https://github.com/votre-nom-utilisateur/NodeJsFinal.git
cd NodeJsFinal
```

Lancez les services :

```bash
docker-compose up -d --build
```

Accédez aux interfaces :

- **Frontend** : http://localhost:8080
- **Backend** : http://localhost:3000

Arrêter les services :

```bash
docker-compose down
```

## Structure du Projet

Le projet est divisé en deux dossiers principaux :

- **backend** : Contient le serveur Node.js, l'API et la logique d'authentification et de gestion des fichiers.
- **frontend** : Contient l'interface utilisateur développée en Vue.js, qui permet d'interagir avec le backend.

## Fonctionnalités Techniques

### Backend (Node.js)

- **Authentification JWT** : Assure une sécurisation des sessions utilisateur.
- **Base de Données MySQL** : Gestion des utilisateurs, fichiers et liens de partage.
- **API REST** :
   - Inscription/connexion
   - Téléchargement et suppression de fichiers
   - Génération de liens de partage temporaires
   - Suivi du quota d’espace

### Frontend (Vue.js)

- **Tableau de Bord Utilisateur** : Interface pour visualiser les fichiers, le quota d’espace, et exécuter des actions sur les fichiers.
- **UI/UX Améliorée** : Interface intuitive avec des boutons d’action (téléchargement, partage, suppression).
- **Progression de l’Espace Utilisé** : Affiche dynamiquement l’espace utilisé et le quota restant.

## Accès aux Repos Indépendants du Backend et Frontend

Chaque partie du projet est également disponible indépendamment :

- [Frontend](https://github.com/TheKyyn/NodeJsTransferFront)
- [Backend](https://github.com/TheKyyn/NodeJsTransfer)

## Contribuer

1. Forkez le repo
2. Créez une branche pour vos modifications :

```bash
git checkout -b feature/nom-de-la-feature
```

3. Committez vos changements :

```bash
git commit -m 'Ajout d'une nouvelle fonctionnalité'
```

4. Pushez la branche :

```bash
git push origin feature/nom-de-la-feature
```

5. Ouvrez une pull request

## Licence

Ce projet est sous licence MIT. Consultez le fichier LICENSE pour plus d’informations.
