#!/usr/bin/env bash
# Copia apps/landing da main do scapematch para este repo (scapematch-site),
# preserva o CNAME e faz commit/push. Rodar só depois do merge do PR da landing.
set -euo pipefail

root=$(cd "$(dirname "$0")" && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

SRC_REPO="${SRC_REPO:-https://github.com/nicolas00saliba/scapematch.git}"
SRC_REF="${SRC_REF:-origin/main}"

git -C "$tmp" clone --depth 1 --branch main "$SRC_REPO" src
landing="$tmp/src/apps/landing"
test -f "$landing/index.html"
test -f "$landing/styles.css"

cname_backup=
if [ -f "$root/CNAME" ]; then
  cname_backup=$(mktemp)
  cp "$root/CNAME" "$cname_backup"
fi

find "$root" -mindepth 1 -maxdepth 1 \
  ! -name '.git' \
  ! -name '.github' \
  ! -name 'README.md' \
  ! -name 'sync.sh' \
  ! -name 'CNAME' \
  -exec rm -rf {} +

cp -a "$landing"/. "$root"/

if [ -n "$cname_backup" ]; then
  cp "$cname_backup" "$root/CNAME"
  rm -f "$cname_backup"
elif [ ! -f "$root/CNAME" ]; then
  echo 'scapematch.com.br' > "$root/CNAME"
fi

cd "$root"
git add -A
if git diff --cached --quiet; then
  echo "Nada a sincronizar."
  exit 0
fi

if [ -z "$(git config user.email || true)" ]; then
  git config user.name "Nícolas S."
  git config user.email "114191470+nicolas00saliba@users.noreply.github.com"
fi

git commit -m "Sincroniza landing da main do scapematch"
git push origin HEAD:main
echo "Push ok."
