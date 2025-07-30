#!/bin/bash

# Simple secure Git operation wrapper
# Requires: Git + HTTPS access to GitHub

echo "🔐 Git Secure - Enhanced Authentication Wrapper"

# Prompt for credentials
read -s -p "Enter your GitHub token or secure password: " GITHUB_TOKEN
echo ""
read -p "Enter your GitHub username: " GITHUB_USER
read -p "Enter Git operation (push/clone/pull/fetch/submodule update --remote): " OPERATION

# Ensure credentials are set only temporarily
export GIT_ASKPASS="$(mktemp)"
chmod 700 "$GIT_ASKPASS"

# Create a temporary askpass script
cat <<EOF > "$GIT_ASKPASS"
#!/bin/sh
echo "$GITHUB_TOKEN"
EOF

chmod +x "$GIT_ASKPASS"

# Execute selected Git command securely
case "$OPERATION" in
  push)
    echo "Executing: git push"
    GIT_TERMINAL_PROMPT=0 GIT_ASKPASS="$GIT_ASKPASS" git push
    ;;
  clone)
    read -p "Enter the repository URL to clone: " REPO_URL
    echo "Executing: git clone $REPO_URL"
    GIT_TERMINAL_PROMPT=0 GIT_ASKPASS="$GIT_ASKPASS" git clone "$REPO_URL"
    ;;
  pull)
    echo "Executing: git pull"
    GIT_TERMINAL_PROMPT=0 GIT_ASKPASS="$GIT_ASKPASS" git pull
    ;;
  fetch)
    echo "Executing: git fetch"
    GIT_TERMINAL_PROMPT=0 GIT_ASKPASS="$GIT_ASKPASS" git fetch
    ;;
  "submodule update --remote")
    echo "Executing: git submodule update --remote"
    GIT_TERMINAL_PROMPT=0 GIT_ASKPASS="$GIT_ASKPASS" git submodule update --remote
    ;;
  *)
    echo "❌ Unsupported operation. Use push, clone, pull, fetch, or submodule update --remote."
    ;;
esac

# Cleanup
rm -f "$GIT_ASKPASS"
unset GIT_ASKPASS
unset GITHUB_TOKEN
unset GITHUB_USER

echo "✅ Operation complete. Temporary credentials removed."
