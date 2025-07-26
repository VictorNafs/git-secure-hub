# git-secure

## 🔐 Objectif

Ce projet propose une commande Git sécurisée (`git-secure`) qui demande explicitement une authentification par token GitHub ou mot de passe généré via un gestionnaire sécurisé avant d'effectuer une opération sensible (`git push` ou `git clone`). Cette commande renforce la sécurité en empêchant l'exposition involontaire des tokens d'accès, notamment en cas de vol ou d'accès physique non autorisé à la machine.

---

## 💡 Pourquoi ?

- Éviter les erreurs accidentelles lors des opérations sensibles (`push`, `clone`).
- Éviter de stocker durablement les clés ou tokens sur la machine locale.
- Fournir une sécurité accrue dans les environnements partagés ou CI/CD.
- Protéger efficacement les tokens GitHub en cas de perte ou vol de matériel informatique.
- Favoriser les contributions ouvertes et les retours de la communauté.

---

## 🚀 Fonctionnalités

- Authentification interactive par saisie sécurisée du token ou d'un mot de passe simplifié.
- Token utilisé temporairement, puis effacé immédiatement.
- Aucune trace persistante du token localement.

---

## 🛠️ Utilisation

Téléchargez simplement le script [`git-secure.sh`](./git-secure.sh) puis rendez-le exécutable :

```bash

chmod +x git-secure.sh

```
Puis lancez-le avec la commande suivante :

```bash

./git-secure.sh

```

## 🔄 Plan de développement

- [ ] Rendre le script multiplateforme (Bash, Python ou Rust).
- [ ] Ajouter une intégration API avec gestionnaire de mots de passe (1Password, Bitwarden).
- [ ] Intégrer un support natif à Git Credential Manager.
- [ ] Rédiger des tests automatisés ainsi qu'une documentation complète et claire.
