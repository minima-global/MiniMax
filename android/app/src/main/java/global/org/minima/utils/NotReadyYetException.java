package global.org.minima.utils;

import androidx.annotation.Nullable;

public class NotReadyYetException extends Exception {
    final String message;

    public NotReadyYetException(String message) {
        this.message = message;
    }

    @Nullable
    @Override
    public String getMessage() {
        return message;
    }
}
