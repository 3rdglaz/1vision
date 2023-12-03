package recipe.one

import recipe.one.validation.ValidationHandler

sealed class Entity<ID: Identifier> (private val id: ID) {

    fun getId(): ID {
        return this.id
    }

    abstract fun validate(handler: ValidationHandler)
}
