package recipe.one.user

import recipe.one.AggregateRoot
import recipe.one.utils.InstantUtils
import recipe.one.validation.ValidationHandler
import java.time.Instant

class User : AggregateRoot<UserID> {

    var id: UserID
        private set
    var name: String
        private set
    var email: String
        private set
    var isConfirmed: Boolean
        private set
    var password: String
        private set
    var isActive: Boolean
        private set
    var createdAt: Instant
        private set
    var updatedAt: Instant
        private set
    var deletedAt: Instant?
        private set

    constructor(
        id: UserID,
        name: String,
        email: String,
        isConfirmed: Boolean,
        password: String,
        isActive: Boolean,
        createdAt: Instant,
        updatedAt: Instant,
        deletedAt: Instant?
    ) : super(id) {
        this.id = id
        this.name = name
        this.email = email
        this.isConfirmed = isConfirmed
        this.password = password
        this.isActive = isActive
        this.createdAt = createdAt
        this.updatedAt = updatedAt
        this.deletedAt = deletedAt
    }

    companion object {
        public fun new(
            name: String,
            email: String,
            isConfirmed: Boolean,
            password: String,
            isActive: Boolean,
        ): User {
            val now = InstantUtils.now()
            return User(
                id = UserID.unique(),
                name = name,
                email = email,
                isConfirmed = isConfirmed,
                password = password,
                isActive = isActive,
                createdAt = now,
                updatedAt = now,
                deletedAt = when {
                    isActive -> null
                    else -> now
                }
            )
        }
    }

    override fun validate(handler: ValidationHandler) =
        UserValidator(this, handler).validate()

    fun activate(): User {
        this.deletedAt = null
        this.updatedAt = InstantUtils.now()
        this.isActive = true
        return this
    }

    fun deactivate(): User {
        val now = InstantUtils.now()

        if (deletedAt == null) {
            this.deletedAt = now
        }
        this.updatedAt = now

        this.isActive = false
        return this
    }

    fun update(
        name: String,
        email: String,
        isConfirmed: Boolean,
        password: String,
        isActive: Boolean
    ): User {
        this.name = name
        this.email = email
        this.isConfirmed = isConfirmed
        this.password = password
        if (isActive) activate() else deactivate()
        return this
    }
}