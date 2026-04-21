#!/usr/bin/env bash
set -euo pipefail

base_dir="${HOME}/Library/Application Support/JetBrains"
if [[ ! -d "${base_dir}" ]]; then
  echo "JetBrains config directory not found: ${base_dir}" >&2
  exit 1
fi

found=0
while IFS= read -r -d '' file; do
  found=1
  if ! grep -q 'pattern="\\*\\.vomd"' "$file"; then
    perl -0pi -e 's#<extensionMap>#<extensionMap>\n      <mapping pattern="*.vomd" type="JSON" />\n      <mapping pattern="*.vocs" type="JSON" />\n      <mapping pattern="*.voud" type="JSON" /># unless /pattern="\\*\\.vomd"/s' "$file"
    echo "Updated: $file"
  else
    echo "Already contains mappings: $file"
  fi
done < <(find "${base_dir}" -path '*/options/filetypes.xml' -print0)

if [[ "$found" -eq 0 ]]; then
  echo "No JetBrains filetypes.xml files found under ${base_dir}" >&2
  exit 1
fi
