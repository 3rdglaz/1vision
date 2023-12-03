package recipe.one.exception

open class DomainException : NoStacktraceException {

    private var errors: List<Error>


    constructor(message: String, errors: List<Error>) : super(message) {
        this.errors = errors
    }

    companion object {
        fun with(error: Error): DomainException =
            DomainException(error.message.toString(), listOf(error))

        fun with(errors: List<Error>) =
            DomainException("", errors)
    }

    public fun getErrors(): List<Error> {
        return this.errors
    }
}