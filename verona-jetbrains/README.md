# Verona for JetBrains

Verona adds first-class support for `*.vomd`, `*.vocs`, and `*.voud` files in JetBrains IDEs.

## What it does

- Recognizes Verona files in the editor
- Backs them with JetBrains' JSON language support
- Adds an explicit `Format As JSON` action in the editor context menu

## Install

1. Download `verona-jetbrains-1.0.0.jar` or `verona-jetbrains-1.0.0.zip` from the [GitHub release page](https://github.com/iqb-berlin/verona-ide-support/releases/tag/v1.0.0)
2. Open `Settings` / `Preferences`
3. Go to `Plugins`
4. Click the gear icon
5. Choose `Install Plugin from Disk...`
6. Select the downloaded artifact

## Notes

- The formatter expects valid JSON content.
- If your Verona files use comments or trailing commas, the plugin should be upgraded to JSON5-aware formatting.
