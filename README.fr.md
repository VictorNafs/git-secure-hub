
---

### 🇫🇷 `README.fr.md`

```markdown
# 🔐 git-secure

Un script sécurisé pour Git, qui exige une authentification interactive avant d'exécuter des opérations sensibles.

📄 Disponible aussi en [🇬🇧 English](README.md)

---

## 💡 Motivation

Les opérations Git comme `push`, `clone`, `pull` ou `fetch` peuvent s'exécuter silencieusement si les identifiants sont stockés (via clé SSH ou token local). Cela représente un risque sur des machines partagées ou compromises.

Ce wrapper demande à l'utilisateur un token GitHub ou mot de passe sécurisé **à chaque utilisation**, sans cache ni sauvegarde.

---

## 🚀 Commandes prises en charge

- `git push`
- `git clone`
- `git pull`
- `git fetch`
- `git submodule update --remote`

Chaque commande déclenche une demande d'identifiants.

---

## 🔐 Exemple

```bash
./git-secure.sh
🔐 Entrez votre token GitHub ou mot de passe :
👤 Nom d'utilisateur GitHub :
🚀 Opération Git (push/clone/pull/fetch/submodule update --remote) :
