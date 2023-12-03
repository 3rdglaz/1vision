package recipe.one.user

import org.junit.jupiter.api.assertDoesNotThrow
import org.junit.jupiter.api.assertThrows
import recipe.one.exception.DomainException
import recipe.one.utils.InstantUtils
import recipe.one.validation.handler.ThrowsValidationHandler
import kotlin.test.*

class UserTest {

    @Test
    fun `given valids params when call new should return a new user`() {
        val name = "name"
        val email = "email@example.com"
        val isConfirmed = false
        val password = "Password2@@"
        val isActive = true
        val now = InstantUtils.now()

        val newUser = User.new(name, email, isConfirmed, password, isActive)

        assertNotNull(newUser)
        assertNotNull(newUser.getId())
        assertEquals(newUser.name, name)
        assertEquals(newUser.email, email)
        assertEquals(newUser.isConfirmed, isConfirmed)
        assertEquals(newUser.password, password)
        assertEquals(newUser.isActive, isActive)
        assertTrue(now.isBefore(newUser.createdAt))
        assertTrue(now.isBefore(newUser.updatedAt))
        assertNull(newUser.deletedAt)
        assertDoesNotThrow {
            newUser.validate(ThrowsValidationHandler())
        }
    }

    @Test
    fun `given valids params with isActive false when call new should return a new user`() {
        val name = "name"
        val email = "email@example.com"
        val isConfirmed = false
        val password = "Password2@@"
        val isActive = false
        val now = InstantUtils.now()

        val newUser = User.new(name, email, isConfirmed, password, isActive)

        assertNotNull(newUser)
        assertNotNull(newUser.getId())
        assertEquals(newUser.name, name)
        assertEquals(newUser.email, email)
        assertEquals(newUser.isConfirmed, isConfirmed)
        assertEquals(newUser.password, password)
        assertEquals(newUser.isActive, isActive)
        assertTrue(now.isBefore(newUser.createdAt))
        assertTrue(now.isBefore(newUser.updatedAt))
        assertTrue(now.isBefore(newUser.deletedAt))
        assertDoesNotThrow {
            newUser.validate(ThrowsValidationHandler())
        }
    }

    // Validation

    @Test
    fun `given a name with less than 3 characters should return a exception`() {
        val name = "na"
        val email = "email@example.com"
        val isConfirmed = false
        val password = "password"
        val isActive = true

        val expectedCount = 1
        val expectedDescription = "'name' should have between 3 and 255 characters"

        val exception = assertThrows<DomainException> {
            User.new(name, email, isConfirmed, password, isActive)
                .validate(ThrowsValidationHandler())
        }

        assertEquals(expectedDescription, exception.getErrors()[0].message)
        assertEquals(expectedCount, exception.getErrors().size)
    }

    @Test
    fun `given a name with more than 255 characters should return a exception`() {
        val name = """
                Gostaria de enfatizar que o consenso sobre a necessidade de qualificação auxilia a preparação e a
                composição das posturas dos órgãos dirigentes com relação às suas atribuições.
                Do mesmo modo, a estrutura atual da organização apresenta tendências no sentido de aprovar a
                manutenção das novas proposições.
                """;
        val email = "email@example.com"
        val isConfirmed = false
        val password = "password"
        val isActive = true

        val expectedCount = 1
        val expectedDescription = "'name' should have between 3 and 255 characters"

        val exception = assertThrows<DomainException> {
            User.new(name, email, isConfirmed, password, isActive)
                .validate(ThrowsValidationHandler())
        }

        assertEquals(expectedDescription, exception.getErrors()[0].message)
        assertEquals(expectedCount, exception.getErrors().size)
    }

    @Test
    fun `given a weak password should return a exception`() {
        val name = "name"
        val email = "email@exaple.com"
        val isConfirmed = false
        val password = "password"
        val isActive = true

        val expectedCount = 1
        val expectedDescription = "'password' should have 1 special character, 1 capital " +
                "letter, 1 number and 8 characters in total"

        val exception = assertThrows<DomainException> {
            User.new(name, email, isConfirmed, password, isActive)
                .validate(ThrowsValidationHandler())
        }

        assertEquals(expectedDescription, exception.getErrors()[0].message)
        assertEquals(expectedCount, exception.getErrors().size)
    }

    @Test
    fun `given an invalid email should return a exception`() {
        val name = "name"
        val email = "email@."
        val isConfirmed = false
        val password = "password"
        val isActive = true

        val expectedCount = 1
        val expectedDescription = "'email' should be valid"

        val exception = assertThrows<DomainException> {
            User.new(name, email, isConfirmed, password, isActive)
                .validate(ThrowsValidationHandler())
        }

        assertEquals(expectedDescription, exception.getErrors()[0].message)
        assertEquals(expectedCount, exception.getErrors().size)
    }

    // activate and inactivate

    @Test
    fun `given a valid and active user when call deactive should return inactive user`() {
        val name = "name"
        val email = "email@example.com"
        val isConfirmed = false
        val password = "Password2@@"
        val isActive = true

        val activeUser = User.new(name, email, isConfirmed, password, isActive)

        val now = InstantUtils.now()
        val inactiveUser = activeUser.deactivate()

        assertDoesNotThrow {
            inactiveUser.validate(ThrowsValidationHandler())
        }

        assertNotNull(inactiveUser)
        assertNotNull(inactiveUser.getId())
        assertEquals(inactiveUser.name, name)
        assertEquals(inactiveUser.email, email)
        assertEquals(inactiveUser.isConfirmed, isConfirmed)
        assertEquals(inactiveUser.password, password)
        assertEquals(inactiveUser.isActive, false)
        assertTrue(now.isAfter(inactiveUser.createdAt))
        assertTrue(now.isBefore(inactiveUser.updatedAt))
        assertTrue(now.isBefore(inactiveUser.deletedAt))
    }

    @Test
    fun `given a valid and inactive user when call active should return active user`() {
        val name = "name"
        val email = "email@example.com"
        val isConfirmed = false
        val password = "Password2@@"
        val isActive = false

        val activeUser = User.new(name, email, isConfirmed, password, isActive)

        val now = InstantUtils.now()
        val inactiveUser = activeUser.activate()

        assertDoesNotThrow {
            inactiveUser.validate(ThrowsValidationHandler())
        }

        assertNotNull(inactiveUser)
        assertNotNull(inactiveUser.getId())
        assertEquals(inactiveUser.name, name)
        assertEquals(inactiveUser.email, email)
        assertEquals(inactiveUser.isConfirmed, isConfirmed)
        assertEquals(inactiveUser.password, password)
        assertEquals(inactiveUser.isActive, true)
        assertTrue(now.isAfter(inactiveUser.createdAt))
        assertTrue(now.isBefore(inactiveUser.updatedAt))
        assertNull(inactiveUser.deletedAt)
    }


    // Update

    @Test
    fun `given valids when call update should return updated user`() {
        val name = "name"
        val email = "email@example.com"
        val isConfirmed = false
        val password = "Password2@@"
        val isActive = true

        val newUser = User.new(name, email, isConfirmed, password, isActive)

        assertDoesNotThrow {
            newUser.validate(ThrowsValidationHandler())
        }

        val newName = "nameNew"
        val newEmail = "new@example.com"
        val newIsConfirmed = true
        val newPassword = "Password2@@NEW"
        val newIsActive = true

        val now = InstantUtils.now()
        val updatedUser = newUser.update(
            newName, newEmail, newIsConfirmed, newPassword, newIsActive
        )

        assertNotNull(newUser)
        assertNotNull(newUser.getId())
        assertEquals(newUser.name, newName)
        assertEquals(updatedUser.email, newEmail)
        assertEquals(updatedUser.isConfirmed, newIsConfirmed)
        assertEquals(updatedUser.password, newPassword)
        assertEquals(updatedUser.isActive, newIsActive)
        assertTrue(now.isAfter(updatedUser.createdAt))
        assertTrue(now.isBefore(updatedUser.updatedAt))
        assertNull(updatedUser.deletedAt)
    }

    @Test
    fun `given a valid active user when call update should return updated and inactive user`() {
        val name = "name"
        val email = "email@example.com"
        val isConfirmed = false
        val password = "Password2@@"
        val isActive = true

        val newUser = User.new(name, email, isConfirmed, password, isActive)

        assertDoesNotThrow {
            newUser.validate(ThrowsValidationHandler())
        }

        val newName = "nameNew"
        val newEmail = "new@example.com"
        val newIsConfirmed = true
        val newPassword = "Password2@@NEW"
        val newIsActive = false

        val now = InstantUtils.now()
        val updatedUser = newUser.update(
            newName, newEmail, newIsConfirmed, newPassword, newIsActive
        )

        assertNotNull(newUser)
        assertNotNull(newUser.getId())
        assertEquals(newUser.name, newName)
        assertEquals(updatedUser.email, newEmail)
        assertEquals(updatedUser.isConfirmed, newIsConfirmed)
        assertEquals(updatedUser.password, newPassword)
        assertEquals(updatedUser.isActive, false)
        assertTrue(now.isAfter(updatedUser.createdAt))
        assertTrue(now.isBefore(updatedUser.updatedAt))
        assertTrue(now.isBefore(updatedUser.deletedAt))
    }
    @Test
    fun `given an inactive user when call update with isActive true should return updated and active  user`() {
        val name = "name"
        val email = "email@example.com"
        val isConfirmed = false
        val password = "Password2@@"
        val isActive = false

        val newUser = User.new(name, email, isConfirmed, password, isActive)

        assertDoesNotThrow {
            newUser.validate(ThrowsValidationHandler())
        }

        val newName = "nameNew"
        val newEmail = "new@example.com"
        val newIsConfirmed = true
        val newPassword = "Password2@@NEW"
        val newIsActive = true

        val now = InstantUtils.now()
        val updatedUser = newUser.update(
            newName, newEmail, newIsConfirmed, newPassword, newIsActive
        )

        assertNotNull(newUser)
        assertNotNull(newUser.getId())
        assertEquals(newUser.name, newName)
        assertEquals(updatedUser.email, newEmail)
        assertEquals(updatedUser.isConfirmed, newIsConfirmed)
        assertEquals(updatedUser.password, newPassword)
        assertEquals(updatedUser.isActive, true)
        assertTrue(now.isAfter(updatedUser.createdAt))
        assertTrue(now.isBefore(updatedUser.updatedAt))
        assertNull(updatedUser.deletedAt)
    }
}