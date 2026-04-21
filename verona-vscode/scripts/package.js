"use strict";

const fs = require("fs");
const path = require("path");
const { spawnSync } = require("child_process");

const packageJsonPath = path.join(__dirname, "..", "package.json");
const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, "utf8"));
const version = packageJson.version;
const outputPath = path.join("dist", `verona-vscode-${version}.vsix`);
fs.mkdirSync(path.join(__dirname, "..", "dist"), { recursive: true });
const vsceBinary = path.join(
  __dirname,
  "..",
  "node_modules",
  ".bin",
  process.platform === "win32" ? "vsce.cmd" : "vsce"
);

const result = spawnSync(vsceBinary, ["package", "--allow-missing-repository", "-o", outputPath], {
  stdio: "inherit",
  cwd: path.join(__dirname, "..")
});

if (result.status !== 0) {
  process.exit(result.status ?? 1);
}
