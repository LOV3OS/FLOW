#!/bin/bash

set -e

echo "[FLO] 🚀 Starting FLOW system bootstrap..."

# ========== SYSTEM PREP ==========
echo "[FLO] 📦 Installing system packages..."
apt update && apt install -y curl git sudo bash gnupg

# ========== PROJECT DIR ==========
echo "[FLO] 🗂 Setting up /flow..."
mkdir -p /flow
chown -R $(whoami) /flow

# ========== CLONE REPO ==========
echo "[FLO] ⬇️ Cloning FLOW repository..."
git clone https://github.com/LOV3OS/FLOW.git /flow || echo "[FLO] ⚠️ Repo already cloned"

# ========== SETUP SHELL ==========
echo "[FLO] ⚙️  Creating .flowrc shell config..."
cat <<EOF > /flow/.flowrc
export FLOW_HOME=/flow
export PATH=\$FLOW_HOME/bin:\$PATH
alias flow="cd /flow && ls"
EOF

echo 'source /flow/.flowrc' >> ~/.bashrc

# ========== VAULT + PASA ==========
echo "[FLO] 🔐 Preparing Vault and PASA integration..."
mkdir -p /flow/vault /flow/logs /flow/config
touch /flow/vault/secrets.env /flow/logs/pasa.log

# ========== DONE ==========
echo "[FLO] ✅ FLOW Bootstrap Complete"
echo "[FLO] 👉 Type 'flow' to enter the FLOW directory"
