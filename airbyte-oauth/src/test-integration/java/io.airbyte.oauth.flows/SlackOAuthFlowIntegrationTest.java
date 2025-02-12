/*
 * Copyright (c) 2020-2025 Airbyte, Inc., all rights reserved.
 */

package io.airbyte.oauth.flows;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

import com.fasterxml.jackson.databind.JsonNode;
import com.google.common.collect.ImmutableMap;
import io.airbyte.commons.json.Jsons;
import io.airbyte.config.SourceOAuthParameter;
import io.airbyte.config.persistence.ConfigNotFoundException;
import io.airbyte.data.services.OAuthService;
import io.airbyte.oauth.OAuthFlowImplementation;
import io.airbyte.validation.json.JsonValidationException;
import java.io.IOException;
import java.net.http.HttpClient;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

@Tag("oauth")
public class SlackOAuthFlowIntegrationTest extends OAuthFlowIntegrationTest {

  @Override
  protected Path getCredentialsPath() {
    return Path.of("secrets/slack.json");
  }

  @Override
  protected String getRedirectUrl() {
    return "https://27b0-2804-14d-2a76-9a9a-fdbb-adee-9e5d-6c.ngrok.io/auth_flow";
  }

  @Override
  protected OAuthFlowImplementation getFlowImplementation(final OAuthService oauthService, final HttpClient httpClient) {
    return new SlackOAuthFlow(httpClient);
  }

  @Test
  public void testFullSlackOAuthFlow() throws InterruptedException, ConfigNotFoundException, IOException, JsonValidationException {
    int limit = 20;
    final UUID workspaceId = UUID.randomUUID();
    final UUID definitionId = UUID.randomUUID();
    final String fullConfigAsString = Files.readString(getCredentialsPath());
    final JsonNode credentialsJson = Jsons.deserialize(fullConfigAsString).get("credentials");
    SourceOAuthParameter sourceOAuthParameter = new SourceOAuthParameter()
        .withOauthParameterId(UUID.randomUUID())
        .withSourceDefinitionId(definitionId)
        .withWorkspaceId(workspaceId)
        .withConfiguration(Jsons.jsonNode(ImmutableMap.builder()
            .put("client_id", credentialsJson.get("client_id").asText())
            .put("client_secret", credentialsJson.get("client_secret").asText())
            .build()));
    when(oauthService.getSourceOAuthParameterOptional(any(), any())).thenReturn(Optional.of(sourceOAuthParameter));
    final String url = getFlowImplementation(oauthService, httpClient).getSourceConsentUrl(workspaceId, definitionId, getRedirectUrl(),
        Jsons.emptyObject(), null, sourceOAuthParameter.getConfiguration());
    LOGGER.info("Waiting for user consent at: {}", url);
    // TODO: To automate, start a selenium job to navigate to the Consent URL and click on allowing
    // access...
    while (!serverHandler.isSucceeded() && limit > 0) {
      Thread.sleep(1000);
      limit -= 1;
    }
    assertTrue(serverHandler.isSucceeded(), "Failed to get User consent on time");
    final Map<String, Object> params = flow.completeSourceOAuth(workspaceId, definitionId,
        Map.of("code", serverHandler.getParamValue()), getRedirectUrl(), sourceOAuthParameter.getConfiguration());
    LOGGER.info("Response from completing OAuth Flow is: {}", params.toString());
    assertTrue(params.containsKey("credentials"));
    assertTrue(((Map<String, Object>) params.get("credentials")).containsKey("access_token"));
    assertTrue(((Map<String, Object>) params.get("credentials")).get("access_token").toString().length() > 0);
  }

}
