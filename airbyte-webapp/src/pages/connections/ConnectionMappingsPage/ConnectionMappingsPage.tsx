import { FormattedMessage, useIntl } from "react-intl";

import { FormChangeTracker } from "components/forms/FormChangeTracker";
import { PageContainer } from "components/PageContainer";
import { Button } from "components/ui/Button";
import { FlexContainer } from "components/ui/Flex";
import { Heading } from "components/ui/Heading";
import { ScrollParent } from "components/ui/ScrollParent";

import { FeatureItem, IfFeatureDisabled, IfFeatureEnabled } from "core/services/features";
import { useConnectionEditService } from "hooks/services/ConnectionEdit/ConnectionEditService";
import { useConnectionFormService } from "hooks/services/ConnectionForm/ConnectionFormService";
import { useNotificationService } from "hooks/services/Notification";

import { ConnectionMappingsList } from "./ConnectionMappingsList";
import { MappingContextProvider, useMappingContext, MAPPING_VALIDATION_ERROR_KEY } from "./MappingContext";
import { MappingsEmptyState } from "./MappingsEmptyState";
import { MappingsUpsellEmptyState } from "./MappingsUpsellEmptyState";

export const ConnectionMappingsPage = () => {
  return (
    <ScrollParent>
      <PageContainer centered>
        <MappingContextProvider>
          <ConnectionMappingsPageContent />
        </MappingContextProvider>
      </PageContainer>
    </ScrollParent>
  );
};

const ConnectionMappingsPageContent = () => {
  const { streamsWithMappings, clear, submitMappings, hasMappingsChanged } = useMappingContext();
  const { mode } = useConnectionFormService();
  const { connectionUpdating } = useConnectionEditService();
  const { registerNotification } = useNotificationService();
  const { formatMessage } = useIntl();

  const handleValidations = async () => {
    const validations = await Promise.allSettled(
      Object.entries(streamsWithMappings).flatMap(([_streamName, mappers]) =>
        mappers.map((mapper) => mapper.validationCallback())
      )
    );

    const hasServerValidationErrors = Object.entries(streamsWithMappings).some(([_, mappings]) => {
      return mappings.some((mapper) => !!mapper.validationError);
    });

    if (
      validations.every((validation) => validation.status === "fulfilled" && validation.value === true) &&
      !hasServerValidationErrors
    ) {
      await submitMappings();
    } else {
      registerNotification({
        type: "error",
        text: formatMessage({ id: "connections.mappings.submissionValidationError" }),
        id: MAPPING_VALIDATION_ERROR_KEY,
      });
    }
  };

  const anyMappersConfigured = Object.entries(streamsWithMappings).some(([_streamName, mappers]) => mappers.length > 0);
  const streamsWithEmptyMappersExist = Object.entries(streamsWithMappings).some(
    ([_streamName, mappers]) => mappers.length === 0
  );
  const showSubmissionButtons = anyMappersConfigured || streamsWithEmptyMappersExist;

  return (
    <>
      <IfFeatureEnabled feature={FeatureItem.MappingsUI}>
        <FlexContainer direction="column">
          <FlexContainer direction="row" justifyContent="space-between" alignItems="center">
            <Heading as="h3" size="sm">
              <FormattedMessage id="connections.mappings.title" />
            </Heading>
            <FormChangeTracker formId="mapping-form" changed={hasMappingsChanged} />
            {showSubmissionButtons && (
              <FlexContainer>
                <Button
                  variant="secondary"
                  onClick={clear}
                  disabled={mode === "readonly" || !hasMappingsChanged || connectionUpdating}
                >
                  <FormattedMessage id="form.cancel" />
                </Button>
                <Button
                  isLoading={connectionUpdating}
                  onClick={handleValidations}
                  disabled={mode === "readonly" || !hasMappingsChanged}
                  data-testid="submit-mappings"
                >
                  <FormattedMessage id="form.submit" />
                </Button>
              </FlexContainer>
            )}
          </FlexContainer>
          {anyMappersConfigured ? <ConnectionMappingsList /> : <MappingsEmptyState />}
        </FlexContainer>
      </IfFeatureEnabled>
      <IfFeatureDisabled feature={FeatureItem.MappingsUI}>
        <MappingsUpsellEmptyState />
      </IfFeatureDisabled>
    </>
  );
};
