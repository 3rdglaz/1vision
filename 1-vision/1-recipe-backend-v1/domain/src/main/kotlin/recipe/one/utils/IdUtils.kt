package recipe.one.utils

import java.util.*

class IdUtils private constructor() {

    companion object {
        fun uuid(): String {
            return UUID
                .randomUUID()
                .toString()
                .lowercase(Locale.getDefault())
                .replace("-", "")
        }
    }
}
