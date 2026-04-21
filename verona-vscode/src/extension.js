"use strict";

const path = require("path");
const vscode = require("vscode");

const SUPPORTED_EXTENSIONS = new Set([".vomd", ".vocs", ".voud"]);

function isSupportedDocument(document) {
  if (!document || document.uri.scheme !== "file") {
    return false;
  }

  return SUPPORTED_EXTENSIONS.has(path.extname(document.uri.fsPath).toLowerCase());
}

async function ensureJsonLanguage(document) {
  if (!document || document.isClosed) {
    return;
  }

  if (document.languageId === "verona-json") {
    await vscode.languages.setTextDocumentLanguage(document, "json");
  }
}

async function formatActiveVeronaEditor() {
  const editor = vscode.window.activeTextEditor;
  if (!editor || !isSupportedDocument(editor.document)) {
    return;
  }

  const originalText = editor.document.getText();
  let formattedText;

  try {
    formattedText = JSON.stringify(JSON.parse(originalText), null, 2);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    void vscode.window.showErrorMessage(`Verona could not format this file as JSON: ${message}`);
    return;
  }

  if (!formattedText.endsWith("\n")) {
    formattedText += "\n";
  }

  if (formattedText === originalText) {
    return;
  }

  const fullRange = new vscode.Range(
    editor.document.positionAt(0),
    editor.document.positionAt(originalText.length)
  );

  await editor.edit((editBuilder) => {
    editBuilder.replace(fullRange, formattedText);
  });
}

function activate(context) {
  for (const document of vscode.workspace.textDocuments) {
    void ensureJsonLanguage(document);
  }

  context.subscriptions.push(
    vscode.workspace.onDidOpenTextDocument((document) => {
      if (isSupportedDocument(document)) {
        void ensureJsonLanguage(document);
      }
    })
  );

  context.subscriptions.push(
    vscode.commands.registerCommand("verona.formatAsJson", async () => {
      await formatActiveVeronaEditor();
    })
  );
}

function deactivate() {}

module.exports = {
  activate,
  deactivate
};
