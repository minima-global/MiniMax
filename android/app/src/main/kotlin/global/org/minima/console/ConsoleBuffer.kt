package global.org.minima.console

class ConsoleBuffer {
    private val messages = mutableListOf<String>()

    fun getMessages(): List<String> = messages

    fun addMessage(message: String): List<String> {
        if (messages.size > maxMessages) {
            messages.removeFirst()
        }

        messages.add(message)

        return messages
    }

    fun clearMessages(): List<String> {
        messages.clear()
        return messages
    }

    companion object {
        private const val maxMessages = 5000
    }
}