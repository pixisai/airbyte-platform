package io.airbyte.server

import io.airbyte.commons.server.support.RbacRoleHelper
import io.airbyte.server.config.community.auth.CommunityAuthProvider
import io.micronaut.context.annotation.Property
import io.micronaut.security.authentication.UsernamePasswordCredentials
import io.micronaut.test.extensions.junit5.annotation.MicronautTest
import jakarta.inject.Inject
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test

@MicronautTest
@Property(name = "airbyte.edition", value = "community")
@Property(name = "micronaut.security.enabled", value = "true")
@Property(name = "airbyte.auth.instanceAdmin.username", value = "test-username")
@Property(name = "airbyte.auth.instanceAdmin.password", value = "test-password")
class CommunityAuthProviderTest {
  @Inject
  private lateinit var communityAuthProvider: CommunityAuthProvider<Nothing>

  @Test
  fun `test authenticate with valid credentials`() {
    val result = communityAuthProvider.authenticate(null, UsernamePasswordCredentials("test-username", "test-password"))
    assertTrue(result!!.isAuthenticated)

    val roles = result.authentication.get().roles
    assertEquals(RbacRoleHelper.getInstanceAdminRoles().toSet(), roles.toSet())
  }

  @Test
  fun `test authenticate with invalid credentials`() {
    val result = communityAuthProvider.authenticate(null, UsernamePasswordCredentials("test-username", "invalid-password"))
    assertFalse(result!!.isAuthenticated)
  }
}
