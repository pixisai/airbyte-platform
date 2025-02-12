/*
 * Copyright (c) 2020-2025 Airbyte, Inc., all rights reserved.
 */

package io.airbyte.server.apis;

import static io.airbyte.commons.auth.AuthRoleConstants.ADMIN;
import static io.airbyte.commons.auth.AuthRoleConstants.AUTHENTICATED_USER;
import static io.airbyte.commons.auth.AuthRoleConstants.ORGANIZATION_READER;
import static io.airbyte.commons.auth.AuthRoleConstants.WORKSPACE_READER;

import io.airbyte.api.generated.DestinationDefinitionApi;
import io.airbyte.api.model.generated.ActorDefinitionIdWithScope;
import io.airbyte.api.model.generated.CustomDestinationDefinitionCreate;
import io.airbyte.api.model.generated.DestinationDefinitionIdRequestBody;
import io.airbyte.api.model.generated.DestinationDefinitionIdWithWorkspaceId;
import io.airbyte.api.model.generated.DestinationDefinitionRead;
import io.airbyte.api.model.generated.DestinationDefinitionReadList;
import io.airbyte.api.model.generated.DestinationDefinitionUpdate;
import io.airbyte.api.model.generated.PrivateDestinationDefinitionRead;
import io.airbyte.api.model.generated.PrivateDestinationDefinitionReadList;
import io.airbyte.api.model.generated.ScopeType;
import io.airbyte.api.model.generated.WorkspaceIdRequestBody;
import io.airbyte.commons.auth.generated.Intent;
import io.airbyte.commons.auth.permissions.RequiresIntent;
import io.airbyte.commons.server.handlers.DestinationDefinitionsHandler;
import io.airbyte.commons.server.scheduling.AirbyteTaskExecutors;
import io.airbyte.commons.server.validation.ActorDefinitionAccessValidator;
import io.micronaut.context.annotation.Context;
import io.micronaut.http.HttpStatus;
import io.micronaut.http.annotation.Body;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Post;
import io.micronaut.http.annotation.Status;
import io.micronaut.scheduling.annotation.ExecuteOn;
import io.micronaut.security.annotation.Secured;
import io.micronaut.security.rules.SecurityRule;

@Controller("/api/v1/destination_definitions")
@Context
@Secured(SecurityRule.IS_AUTHENTICATED)
public class DestinationDefinitionApiController implements DestinationDefinitionApi {

  private final DestinationDefinitionsHandler destinationDefinitionsHandler;
  private final ActorDefinitionAccessValidator accessValidator;

  public DestinationDefinitionApiController(final DestinationDefinitionsHandler destinationDefinitionsHandler,
                                            final ActorDefinitionAccessValidator accessValidator) {
    this.destinationDefinitionsHandler = destinationDefinitionsHandler;
    this.accessValidator = accessValidator;
  }

  @SuppressWarnings("LineLength")
  @Post(uri = "/create_custom")
  @RequiresIntent(Intent.UploadCustomConnector)
  @ExecuteOn(AirbyteTaskExecutors.IO)
  @Override
  public DestinationDefinitionRead createCustomDestinationDefinition(@Body final CustomDestinationDefinitionCreate customDestinationDefinitionCreate) {
    // legacy calls contain workspace id instead of scope id and scope type
    if (customDestinationDefinitionCreate.getWorkspaceId() != null) {
      customDestinationDefinitionCreate.setScopeType(ScopeType.WORKSPACE);
      customDestinationDefinitionCreate.setScopeId(customDestinationDefinitionCreate.getWorkspaceId());
    }
    return ApiHelper.execute(() -> destinationDefinitionsHandler.createCustomDestinationDefinition(customDestinationDefinitionCreate));
  }

  @Post(uri = "/delete")
  // the accessValidator will provide additional authorization checks, depending on Airbyte edition.
  @Secured({AUTHENTICATED_USER})
  @ExecuteOn(AirbyteTaskExecutors.IO)
  @Override
  @Status(HttpStatus.NO_CONTENT)
  public void deleteDestinationDefinition(@Body final DestinationDefinitionIdRequestBody destinationDefinitionIdRequestBody) {
    accessValidator.validateWriteAccess(destinationDefinitionIdRequestBody.getDestinationDefinitionId());
    ApiHelper.execute(() -> {
      destinationDefinitionsHandler.deleteDestinationDefinition(destinationDefinitionIdRequestBody);
      return null;
    });
  }

  @Post(uri = "/get")
  @Secured({AUTHENTICATED_USER})
  @ExecuteOn(AirbyteTaskExecutors.IO)
  @Override
  public DestinationDefinitionRead getDestinationDefinition(@Body final DestinationDefinitionIdRequestBody destinationDefinitionIdRequestBody) {
    return ApiHelper.execute(() -> destinationDefinitionsHandler.getDestinationDefinition(destinationDefinitionIdRequestBody));
  }

  @Post("/get_for_scope")
  @Secured({WORKSPACE_READER, ORGANIZATION_READER})
  @ExecuteOn(AirbyteTaskExecutors.IO)
  @Override
  public DestinationDefinitionRead getDestinationDefinitionForScope(@Body final ActorDefinitionIdWithScope actorDefinitionIdWithScope) {
    return ApiHelper.execute(() -> destinationDefinitionsHandler.getDestinationDefinitionForScope(actorDefinitionIdWithScope));
  }

  @SuppressWarnings("LineLength")
  @Post(uri = "/get_for_workspace")
  @Secured({WORKSPACE_READER, ORGANIZATION_READER})
  @ExecuteOn(AirbyteTaskExecutors.IO)
  @Override
  public DestinationDefinitionRead getDestinationDefinitionForWorkspace(
                                                                        @Body final DestinationDefinitionIdWithWorkspaceId destinationDefinitionIdWithWorkspaceId) {
    return ApiHelper.execute(() -> destinationDefinitionsHandler.getDestinationDefinitionForWorkspace(destinationDefinitionIdWithWorkspaceId));
  }

  @SuppressWarnings("LineLength")
  @Post(uri = "/grant_definition")
  @Secured({ADMIN})
  @ExecuteOn(AirbyteTaskExecutors.IO)
  @Override
  public PrivateDestinationDefinitionRead grantDestinationDefinition(@Body final ActorDefinitionIdWithScope actorDefinitionIdWithScope) {
    return ApiHelper.execute(() -> destinationDefinitionsHandler.grantDestinationDefinitionToWorkspaceOrOrganization(actorDefinitionIdWithScope));
  }

  @Post(uri = "/list")
  @Secured({AUTHENTICATED_USER})
  @ExecuteOn(AirbyteTaskExecutors.IO)
  @Override
  public DestinationDefinitionReadList listDestinationDefinitions() {
    return ApiHelper.execute(destinationDefinitionsHandler::listDestinationDefinitions);
  }

  @Post(uri = "/list_for_workspace")
  @Secured({WORKSPACE_READER, ORGANIZATION_READER})
  @ExecuteOn(AirbyteTaskExecutors.IO)
  @Override
  public DestinationDefinitionReadList listDestinationDefinitionsForWorkspace(@Body final WorkspaceIdRequestBody workspaceIdRequestBody) {
    return ApiHelper.execute(() -> destinationDefinitionsHandler.listDestinationDefinitionsForWorkspace(workspaceIdRequestBody));
  }

  @Post(uri = "/list_latest")
  @Secured({AUTHENTICATED_USER})
  @ExecuteOn(AirbyteTaskExecutors.IO)
  @Override
  public DestinationDefinitionReadList listLatestDestinationDefinitions() {
    return ApiHelper.execute(destinationDefinitionsHandler::listLatestDestinationDefinitions);
  }

  @Post(uri = "/list_private")
  @Secured({ADMIN})
  @ExecuteOn(AirbyteTaskExecutors.IO)
  @Override
  public PrivateDestinationDefinitionReadList listPrivateDestinationDefinitions(@Body final WorkspaceIdRequestBody workspaceIdRequestBody) {
    return ApiHelper.execute(() -> destinationDefinitionsHandler.listPrivateDestinationDefinitions(workspaceIdRequestBody));
  }

  @Post(uri = "/revoke_definition")
  @Secured({ADMIN})
  @ExecuteOn(AirbyteTaskExecutors.IO)
  @Override
  public void revokeDestinationDefinition(@Body final ActorDefinitionIdWithScope actorDefinitionIdWithScope) {
    ApiHelper.execute(() -> {
      destinationDefinitionsHandler.revokeDestinationDefinition(actorDefinitionIdWithScope);
      return null;
    });
  }

  @Post(uri = "/update")
  // the accessValidator will provide additional authorization checks, depending on Airbyte edition.
  @Secured({AUTHENTICATED_USER})
  @ExecuteOn(AirbyteTaskExecutors.IO)
  @Override
  public DestinationDefinitionRead updateDestinationDefinition(@Body final DestinationDefinitionUpdate destinationDefinitionUpdate) {
    accessValidator.validateWriteAccess(destinationDefinitionUpdate.getDestinationDefinitionId());
    return ApiHelper.execute(() -> destinationDefinitionsHandler.updateDestinationDefinition(destinationDefinitionUpdate));
  }

}
