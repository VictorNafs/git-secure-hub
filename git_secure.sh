#!/bin/bash

# git-secure.sh
# Secure Git wrapper that prompts for authentication and validates before running Git operations
# Author: Victor Duprez
# Version: v2.1

set -e

echo "🔐 Git Secure - Enhanced Authentication Wrapper"

# Prompt user for credentials
read -s -p "Enter your GitHub token or secure password: " GITHUB_TOKEN
echo ""
read -p "Enter your GitHub username: " GITHUB_USER
echo ""
read -p "Enter Git operation (push/clone/pull/fetch): " OPERATION

# Temporary file for GIT_ASKPASS
export GIT_ASKPASS=$(mktemp)
chmod 700 "$GIT_ASKPASS"
echo "#!/bin/sh" > "$GIT_ASKPASS"
echo "echo \"$GITHUB_TOKEN\"" >> "$GIT_ASKPASS"
chmod +x "$GIT_ASKPASS"

# Function to validate GitHub token
function validate_token() {
  echo "🔎 Validating GitHub token..."
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" -u "$GITHUB_USER:$GITHUB_TOKEN" https://api.github.com/user)
  if [[ "$STATUS" != "200" ]]; then
    echo "❌ Invalid GitHub token or username. Aborting."
    cleanup
    exit 1
  fi
  echo "✅ Token valid."
}

# Function to validate repo existence (for clone)
function validate_repo_url() {
  REPO_URL=$1
  echo "🔎 Checking repository existence..."
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" -u "$GITHUB_USER:$GITHUB_TOKEN" "$REPO_URL")
  if [[ "$STATUS" != "200" && "$STATUS" != "302" ]]; then
    echo "❌ Repository not accessible or does not exist. Status: $STATUS"
    cleanup
    exit 1
  fi
  echo "✅ Repository reachable."
}

# Cleanup function
function cleanup() {
  rm -f "$GIT_ASKPASS"
  unset GIT_ASKPASS
  unset GITHUB_TOKEN
  unset GITHUB_USER
}

# Main logic
validate_token

case "$OPERATION" in
  push)
    echo "🚀 Executing: git push"
    GIT_TERMINAL_PROMPT=0 GIT_ASKPASS="$GIT_ASKPASS" git push
    ;;
  clone)
    read -p "Enter the repository HTTPS URL to clone: " REPO_URL
    validate_repo_url "$REPO_URL"
    echo "🚀 Executing: git clone $REPO_URL"
    GIT_TERMINAL_PROMPT=0 GIT_ASKPASS="$GIT_ASKPASS" git clone "$REPO_URL"
    ;;
  pull)
    echo "📥 Executing: git pull"
    GIT_TERMINAL_PROMPT=0 GIT_ASKPASS="$GIT_ASKPASS" git pull
    ;;
  fetch)
    echo "🔄 Executing: git fetch"
    GIT_TERMINAL_PROMPT=0 GIT_ASKPASS="$GIT_ASKPASS" git fetch
    ;;
  *)
    echo "❌ Unsupported operation. Use 'push', 'clone', 'pull' or 'fetch'."
    cleanup
    exit 1
    ;;
esac

cleanup
echo "✅ Operation complete. Temporary credentials removed."
