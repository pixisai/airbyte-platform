import React from "react";
import { FormattedMessage, useIntl } from "react-intl";

import { Badge } from "components/ui/Badge";
import { FlexContainer } from "components/ui/Flex";
import { Link } from "components/ui/Link";
import AirbyteLogo from "images/airbyteLogo.svg?react";

import { FeatureItem, IfFeatureEnabled } from "core/services/features";
import { RoutePaths } from "pages/routePaths";

import styles from "./AirbyteHomeLink.module.scss";

export const AirbyteHomeLink: React.FC = () => {
  const { formatMessage } = useIntl();

  return (
    <div className={styles.homeLink}>
      <Link
        to={RoutePaths.Connections}
        aria-label={formatMessage({ id: "sidebar.homepage" })}
        className={styles.homeLink__link}
      >
        <AirbyteLogo height={24} className={styles.homeLink__logo} />
      </Link>
      <IfFeatureEnabled feature={FeatureItem.EnterpriseBranding}>
        <BrandingBadge product="enterprise" testId="enterprise-badge" />
      </IfFeatureEnabled>
      <IfFeatureEnabled feature={FeatureItem.CloudForTeamsBranding}>
        <BrandingBadge product="cloudForTeams" testId="cloud-for-teams-badge" />
      </IfFeatureEnabled>
    </div>
  );
};

export const BrandingBadge: React.FC<{ product: "enterprise" | "cloudForTeams"; testId?: string }> = ({
  product,
  testId,
}) => (
  <Badge variant={product === "enterprise" ? "darkBlue" : "blue"} data-testid={testId}>
    <FlexContainer alignItems="center">
      <FormattedMessage id={product === "enterprise" ? "enterprise.enterprise" : "cloud.cloudForTeams"} />
    </FlexContainer>
  </Badge>
);
