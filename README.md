# 🔐 git-secure

A secure wrapper for Git that enforces interactive authentication before executing sensitive operations.

📄 Also available in [🇫🇷 French](README.fr.md)

---

## 💡 Motivation

Git operations like `push`, `clone`, `pull`, or `fetch` can be run silently if credentials are stored (e.g., in SSH keys or local token caches). This poses a security risk on shared or compromised machines.

This wrapper prompts the user for a GitHub token or secure password **each time**, with no caching or persistence.

---

## 🚀 Supported Commands

- `git push`
- `git clone`
- `git pull`
- `git fetch`
- `git submodule update --remote`

Each command triggers a prompt for a GitHub token and username.

---

## 🔐 Example

```bash
./git-secure.sh
🔐 Enter your GitHub token or secure password:
👤 GitHub username:
🚀 Git operation (push/clone/pull/fetch/submodule update --remote):
