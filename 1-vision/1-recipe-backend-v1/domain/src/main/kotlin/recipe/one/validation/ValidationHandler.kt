package recipe.one.validation

interface ValidationHandler {

    fun append(handler: ValidationHandler): ValidationHandler
    fun append(error: Error): ValidationHandler

    fun <T> validate(aValidator: Validation<T>): T?

    fun getErrors(): List<Error>

    fun hasErrors(): Boolean {
        return getErrors().isNotEmpty()
    }

    fun firstError(): Error? {
        if (getErrors().isNotEmpty()) {
            return getErrors()[0]
        }
        return null
    }

    interface Validation<T> {
        fun validate(): T
    }
}