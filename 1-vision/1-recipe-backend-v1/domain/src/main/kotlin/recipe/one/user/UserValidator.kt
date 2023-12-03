package recipe.one.user

import recipe.one.validation.ValidationHandler
import recipe.one.validation.Validator
import java.util.regex.Pattern

class UserValidator(
    private val user: User,
    private val handler: ValidationHandler
) : Validator(handler) {

    val EMAIL_ADDRESS_PATTERN = Pattern.compile(
        "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" +
                "\\@" +
                "[a-zA-Z0-9][a-zA-Z0-9\\-]{1,64}" +
                "(" +
                "\\." +
                "[a-zA-Z0-9][a-zA-Z0-9\\-]{1,25}" +
                ")+"
    );

    val PASSWORD_PATTERN = Pattern.compile(
        "^" +
                "(?=.*[0-9])" +
                "(?=.*[a-z])" +
                "(?=.*[A-Z])" +
                "(?=.*[@#$%^&+=])" +
                "(?=\\S+$)" +
                ".{8,}" +
                "$"
    )


    override fun validate() {

        val name = user.name

        if (name.isBlank()) {
            this.validationHandler().append(Error("'name' should not be empty"))
            return
        }

        if (name.length < 3 || name.length > 255) {
            this.validationHandler().append(
                Error("'name' should have between 3 and 255 characters")
            )
            return
        }

        val email = user.email
        if (email.isBlank()) {
            this.validationHandler().append(
                Error("'email' should not be blank")
            )
            return
        }

        if (email.length <= 3 || email.length > 255) {
            this.validationHandler().append(
                Error("'email' should have between 3 and 255 characters")
            )
            return
        }

        if (!EMAIL_ADDRESS_PATTERN.matcher(email).matches()) {
            this.validationHandler().append(
                Error("'email' should be valid")
            )
            return
        }

        val password = user.password
        if (password.isBlank()) {
            this.validationHandler().append(
                Error("'password' should not be blank")
            )
            return
        }

        if (PASSWORD_PATTERN.matcher(password).matches().not()) {
            this.validationHandler().append(
                Error(
                    "'password' should have 1 special character, 1 capital " +
                            "letter, 1 number and 8 characters in total"
                )
            )
        }
    }
}