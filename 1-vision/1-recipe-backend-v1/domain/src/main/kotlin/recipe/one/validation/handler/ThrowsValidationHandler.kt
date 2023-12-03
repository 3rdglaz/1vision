package recipe.one.validation.handler

import recipe.one.exception.DomainException
import recipe.one.validation.ValidationHandler

class ThrowsValidationHandler: ValidationHandler {
    override fun append(error: Error): ValidationHandler {
        throw DomainException.with(error)
    }

    override fun append(handler: ValidationHandler): ValidationHandler {
        throw DomainException.with(handler.getErrors())
    }

    override fun <T> validate(aValidator: ValidationHandler.Validation<T>): T {
        try {
            return aValidator.validate()
        } catch (ex: Exception) {
            throw DomainException.with(Error(ex.message))
        }
    }

    override fun getErrors(): List<Error> = emptyList()
}