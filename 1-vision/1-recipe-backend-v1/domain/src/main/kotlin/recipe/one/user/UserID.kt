package recipe.one.user

import recipe.one.Identifier
import recipe.one.utils.IdUtils

class UserID private constructor(private val value: String) : Identifier() {

    companion object {
        fun unique(): UserID = UserID.from(IdUtils.uuid())

        fun from(id: String): UserID = UserID(id)

    }

    override fun getValue(): String = value
}