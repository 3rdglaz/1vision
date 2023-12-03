package recipe.one.validation

open abstract class Validator(private val handler: ValidationHandler) {
    abstract fun validate()

    protected fun validationHandler(): ValidationHandler {
        return this.handler
    }
}
