#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
JETBRAINS_DIR="${ROOT_DIR}/verona-jetbrains"
DIST_DIR="${JETBRAINS_DIR}/dist"
BUILD_DIR="${JETBRAINS_DIR}/build/manual-classes"
VERSION="$(awk -F= '$1=="version" {print $2}' "${JETBRAINS_DIR}/gradle.properties")"
PLUGIN_JAR="${DIST_DIR}/verona-jetbrains-${VERSION}.jar"
PLUGIN_ZIP="${DIST_DIR}/verona-jetbrains-${VERSION}.zip"

rm -f "${PLUGIN_JAR}" "${PLUGIN_ZIP}"
mkdir -p "${DIST_DIR}"

if command -v gradle >/dev/null 2>&1; then
  gradle \
    --project-dir "${JETBRAINS_DIR}" \
    clean \
    jar \
    buildPlugin

  cp "${JETBRAINS_DIR}/build/libs/verona-jetbrains-${VERSION}.jar" "${PLUGIN_JAR}"
  cp "${JETBRAINS_DIR}/build/distributions/verona-jetbrains-${VERSION}.zip" "${PLUGIN_ZIP}"
  exit 0
fi

IDEA_APP="/Applications/IntelliJ IDEA.app"
if [[ ! -d "${IDEA_APP}" ]]; then
  echo "Gradle is not available and ${IDEA_APP} was not found for local fallback compilation." >&2
  exit 1
fi

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

CLASSPATH=""
for jar in "${IDEA_APP}/Contents/plugins/json/lib/json.jar" "${IDEA_APP}/Contents/lib/"*.jar; do
  if [[ -z "${CLASSPATH}" ]]; then
    CLASSPATH="${jar}"
  else
    CLASSPATH="${CLASSPATH}:${jar}"
  fi
done

javac \
  --release 17 \
  -cp "${CLASSPATH}" \
  -d "${BUILD_DIR}" \
  "${JETBRAINS_DIR}/src/main/java/dev/verona/VeronaFileType.java" \
  "${JETBRAINS_DIR}/src/main/java/dev/verona/FormatAsJsonAction.java"

jar --create \
  --file "${PLUGIN_JAR}" \
  -C "${BUILD_DIR}" . \
  -C "${JETBRAINS_DIR}/src/main/resources" .

TMP_DIR="$(mktemp -d)"
mkdir -p "${TMP_DIR}/verona-jetbrains/lib"
cp "${PLUGIN_JAR}" "${TMP_DIR}/verona-jetbrains/lib/verona-jetbrains.jar"
(
  cd "${TMP_DIR}"
  zip -qr "${PLUGIN_ZIP}" verona-jetbrains
)
rm -rf "${TMP_DIR}"
