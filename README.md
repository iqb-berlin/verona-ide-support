# Verona IDE Support

[![CI](https://github.com/iqb-berlin/verona-ide-support/actions/workflows/ci.yml/badge.svg)](https://github.com/iqb-berlin/verona-ide-support/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/iqb-berlin/verona-ide-support?display_name=tag)](https://github.com/iqb-berlin/verona-ide-support/releases)
[![License: MIT](https://img.shields.io/badge/license-MIT-0b4f6c.svg)](./LICENSE)

![Verona banner](./assets/verona-banner.svg)

Verona adds JSON-friendly support for `*.vomd`, `*.vocs`, and `*.voud` files in both VS Code and JetBrains IDEs.

## Why Verona

- recognizes Verona files without manual language switching
- formats them as JSON in both editor families
- makes review and debugging of JSON-based assets much less awkward

## Supported editors

| Editor | What Verona adds |
| --- | --- |
| VS Code | automatic Verona file detection, JSON mode handoff, `Verona: Format As JSON` command |
| JetBrains | dedicated Verona file type, JSON-backed editing, `Format As JSON` in the editor context menu |

## Install

Download the packaged artifacts from the [GitHub Releases page](https://github.com/iqb-berlin/verona-ide-support/releases):

- VS Code: `verona-vscode-1.0.0.vsix`
- JetBrains: `verona-jetbrains-1.0.0.jar`
- JetBrains: `verona-jetbrains-1.0.0.zip`

## Visual preview

![Verona preview](./assets/verona-preview.svg)

## Repository layout

- [verona-vscode](./verona-vscode)
- [verona-jetbrains](./verona-jetbrains)
- [VERONA_TEAM_GUIDE.md](./VERONA_TEAM_GUIDE.md)
- [VERONA_ANNOUNCEMENT.md](./VERONA_ANNOUNCEMENT.md)

## Automation

- CI builds both packages on pushes to `main` and on pull requests
- tag pushes such as `v1.0.1` build fresh artifacts and publish a GitHub release automatically

## License

Released under the [MIT License](./LICENSE).
