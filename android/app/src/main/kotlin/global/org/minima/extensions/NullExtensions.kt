package global.org.minima.extensions

fun <T> T?.orElse(block: () -> T): T {
    return this ?: block()
}