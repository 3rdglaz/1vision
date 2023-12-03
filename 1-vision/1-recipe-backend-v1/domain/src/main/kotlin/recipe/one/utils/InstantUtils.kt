package recipe.one.utils

import java.time.Instant
import java.time.temporal.ChronoUnit

class InstantUtils private constructor() {

    companion object {
        fun now(): Instant = Instant.now().truncatedTo(ChronoUnit.MICROS)
    }
}
