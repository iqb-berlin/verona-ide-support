package dev.verona;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.intellij.openapi.actionSystem.ActionUpdateThread;
import com.intellij.openapi.actionSystem.AnAction;
import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.actionSystem.CommonDataKeys;
import com.intellij.openapi.command.WriteCommandAction;
import com.intellij.openapi.editor.Document;
import com.intellij.openapi.editor.Editor;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.ui.Messages;
import com.intellij.openapi.vfs.VirtualFile;

import java.util.Locale;
import java.util.Set;

public final class FormatAsJsonAction extends AnAction {
    private static final Set<String> SUPPORTED_EXTENSIONS = Set.of("vomd", "vocs", "voud");
    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    @Override
    public ActionUpdateThread getActionUpdateThread() {
        return ActionUpdateThread.BGT;
    }

    @Override
    public void update(AnActionEvent event) {
        VirtualFile file = event.getData(CommonDataKeys.VIRTUAL_FILE);
        boolean supported = isSupported(file);
        event.getPresentation().setVisible(supported);
        event.getPresentation().setEnabled(supported);
    }

    @Override
    public void actionPerformed(AnActionEvent event) {
        Project project = event.getProject();
        Editor editor = event.getData(CommonDataKeys.EDITOR);
        VirtualFile file = event.getData(CommonDataKeys.VIRTUAL_FILE);
        if (project == null || editor == null || !isSupported(file)) {
            return;
        }

        Document document = editor.getDocument();
        String originalText = document.getText();

        final String formattedText;
        try {
            Object parsed = OBJECT_MAPPER.readValue(originalText, Object.class);
            formattedText = OBJECT_MAPPER.writerWithDefaultPrettyPrinter().writeValueAsString(parsed);
        } catch (Exception exception) {
            Messages.showErrorDialog(
                project,
                "The current Verona file could not be formatted as JSON.\n\n" + exception.getMessage(),
                "Verona: Format As JSON"
            );
            return;
        }

        if (formattedText.equals(originalText)) {
            return;
        }

        WriteCommandAction.runWriteCommandAction(project, "Verona: Format As JSON", null, () -> document.setText(formattedText));
    }

    private static boolean isSupported(VirtualFile file) {
        if (file == null) {
            return false;
        }

        String extension = file.getExtension();
        if (extension == null) {
            return false;
        }

        return SUPPORTED_EXTENSIONS.contains(extension.toLowerCase(Locale.ROOT));
    }
}
