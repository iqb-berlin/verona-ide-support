# Verona for VS Code

Verona makes `*.vomd`, `*.vocs`, and `*.voud` feel like JSON files in Visual Studio Code.

## What it does

- Detects Verona file extensions
- Switches them into VS Code's built-in JSON language mode
- Adds a `Verona: Format As JSON` command
- Adds a right-click `Format As JSON` option for Verona files

## Install

1. Download `verona-vscode-1.0.0.vsix` from the [GitHub release page](https://github.com/iqb-berlin/verona-ide-support/releases/tag/v1.0.0)
2. Open Extensions in VS Code
3. Click the `...` menu
4. Choose `Install from VSIX...`
5. Select the downloaded VSIX

## Use

- Open any `.vomd`, `.vocs`, or `.voud` file
- Format it with:
  - right click -> `Verona: Format As JSON`
  - Command Palette -> `Verona: Format As JSON`
  - or the normal VS Code format workflow after the file switches to JSON mode
