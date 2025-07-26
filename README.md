
# git-secure

## 🔐 Objectif

Ce projet propose une commande Git sécurisée (`git-secure-push`) qui demande explicitement une authentification par token ou mot de passe GitHub avant d'effectuer une opération sensible (`git push` ou `git clone`). Cette commande vise à renforcer la sécurité en empêchant l'exposition involontaire des tokens d'accès.

---

## 💡 Pourquoi ?

- Éviter les erreurs accidentelles lors des opérations sensibles (`push`, `clone`).
- Éviter de stocker durablement les clés ou tokens sur la machine locale.
- Fournir une sécurité accrue dans les environnements partagés ou CI/CD.
- Favoriser les contributions ouvertes et les retours de la communauté.

---

## 🚀 Fonctionnalités

- Authentification interactive par saisie sécurisée du token.
- Token utilisé temporairement, puis effacé immédiatement.
- Aucune trace persistante du token localement.

---

## 🛠️ Prototype fonctionnel (`git-secure-push.sh`)

```bash
#!/bin/bash

# Demande sécurisée du token GitHub
read -s -p "🔐 Entrez votre token GitHub : " TOKEN
echo ""

# Stockage temporaire sécurisé du token
TMP_TOKEN_FILE=$(mktemp)
echo "$TOKEN" > "$TMP_TOKEN_FILE"

# Saisie du username GitHub
read -p "👤 Nom d'utilisateur GitHub : " USER

# Extraction automatique de l'URL du remote
REPO=$(git remote get-url origin)

# Push sécurisé avec URL temporaire intégrant le token
git push "https://$USER:$(cat $TMP_TOKEN_FILE)@${REPO#https://}"

# Nettoyage sécurisé immédiat
rm -f "$TMP_TOKEN_FILE"
unset TOKEN
```

---

## 🔄 Plan de développement

- [ ] Rendre le script multiplateforme (Bash, Python ou Rust).
- [ ] Ajouter un mode interactif avancé (avec gestionnaire de mots de passe intégré comme 1Password ou Bitwarden).
- [ ] Proposer une intégration native à Git Credential Manager.
- [ ] Ajouter support pour `git clone` sécurisé.
- [ ] Rédiger tests automatisés.

---

## 📬 Proposer l'idée à la communauté Git

- [ ] Publier une issue claire sur https://github.com/git/git/issues
- [ ] Publier une proposition sur la mailing list officielle : https://git-scm.com/community

---

## 📄 Licence

Ce projet est proposé sous licence MIT.
