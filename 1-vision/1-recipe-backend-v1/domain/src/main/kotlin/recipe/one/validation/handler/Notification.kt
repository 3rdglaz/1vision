package recipe.one.validation.handler

import recipe.one.exception.DomainException
import recipe.one.validation.ValidationHandler

class Notification private constructor(private var errors: MutableList<Error>) :
    ValidationHandler {

    companion object {
        fun create() = Notification(mutableListOf())
        fun create(error: Error) = Notification(mutableListOf(error))
        fun create(throwable: Throwable) = create(Error(throwable.message))
    }

    override fun append(handler: ValidationHandler): ValidationHandler {
        this.errors.addAll(handler.getErrors())
        return this
    }

    override fun append(error: Error): ValidationHandler {
        this.errors.add(error)
        return this
    }

    override fun <T> validate(aValidator: ValidationHandler.Validation<T>): T? {
        try {
            return aValidator.validate()
        } catch (ex: DomainException) {
            this.errors.addAll(ex.getErrors())
        } catch (throwable: Throwable) {
            this.errors.add(Error(throwable.message))
        }
        return null
    }

    override fun getErrors(): List<Error> = this.errors
}