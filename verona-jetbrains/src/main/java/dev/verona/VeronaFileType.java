package dev.verona;

import com.intellij.json.JsonFileType;
import com.intellij.json.JsonLanguage;
import com.intellij.openapi.fileTypes.LanguageFileType;

import javax.swing.Icon;

public final class VeronaFileType extends LanguageFileType {
    public static final VeronaFileType INSTANCE = new VeronaFileType();

    private VeronaFileType() {
        super(JsonLanguage.INSTANCE);
    }

    @Override
    public String getName() {
        return "Verona";
    }

    @Override
    public String getDescription() {
        return "JSON-backed .vomd, .vocs, and .voud files";
    }

    @Override
    public String getDefaultExtension() {
        return "vomd";
    }

    @Override
    public Icon getIcon() {
        return JsonFileType.INSTANCE.getIcon();
    }
}
