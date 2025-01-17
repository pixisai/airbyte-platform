
{{/* DO NOT EDIT: This file was autogenerated. */}}

{{/*
    Temporal Configuration
*/}}

{{/*
Renders the temporal.autoSetup value
*/}}
{{- define "airbyte.temporal.autoSetup" }}
    {{- .Values.temporal.autoSetup | default true }}
{{- end }}

{{/*
Renders the temporal.autoSetup environment variable
*/}}
{{- define "airbyte.temporal.autoSetup.env" }}
- name: AUTO_SETUP
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AUTO_SETUP
{{- end }}

{{/*
Renders the temporal.database.engine value
*/}}
{{- define "airbyte.temporal.database.engine" }}
    {{- .Values.temporal.database.engine | default "postgresql" }}
{{- end }}

{{/*
Renders the temporal.database.engine environment variable
*/}}
{{- define "airbyte.temporal.database.engine.env" }}
- name: DB
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DB
{{- end }}

{{/*
Renders the temporal.database.host environment variable
*/}}
{{- define "airbyte.temporal.database.host.env" }}
- name: POSTGRES_SEEDS
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DATABASE_HOST
{{- end }}

{{/*
Renders the temporal.database.port environment variable
*/}}
{{- define "airbyte.temporal.database.port.env" }}
- name: DB_PORT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DATABASE_PORT
{{- end }}

{{/*
Renders the temporal.database.user secret key
*/}}
{{- define "airbyte.temporal.database.user.secretKey" }}
	{{- .Values.temporal.database.userSecretKey | default "DATABASE_USER" }}
{{- end }}

{{/*
Renders the temporal.database.user environment variable
*/}}
{{- define "airbyte.temporal.database.user.env" }}
- name: POSTGRES_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.database.secretName" . }}
      key: {{ include "airbyte.temporal.database.user.secretKey" . }}
{{- end }}

{{/*
Renders the temporal.database.password secret key
*/}}
{{- define "airbyte.temporal.database.password.secretKey" }}
	{{- .Values.temporal.database.passwordSecretKey | default "DATABASE_PASSWORD" }}
{{- end }}

{{/*
Renders the temporal.database.password environment variable
*/}}
{{- define "airbyte.temporal.database.password.env" }}
- name: POSTGRES_PWD
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.database.secretName" . }}
      key: {{ include "airbyte.temporal.database.password.secretKey" . }}
{{- end }}

{{/*
Renders the temporal.database.tlsEnabled value
*/}}
{{- define "airbyte.temporal.database.tlsEnabled" }}
    {{- ternary "true" "false" (eq .Values.global.database.type "external") }}
{{- end }}

{{/*
Renders the temporal.database.tlsEnabled environment variable
*/}}
{{- define "airbyte.temporal.database.tlsEnabled.env" }}
- name: POSTGRES_TLS_ENABLED
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: POSTGRES_TLS_ENABLED
{{- end }}

{{/*
Renders the temporal.database.tlsDisableHostVerification value
*/}}
{{- define "airbyte.temporal.database.tlsDisableHostVerification" }}
    {{- ternary "true" "false" (eq .Values.global.database.type "external") }}
{{- end }}

{{/*
Renders the temporal.database.tlsDisableHostVerification environment variable
*/}}
{{- define "airbyte.temporal.database.tlsDisableHostVerification.env" }}
- name: POSTGRES_TLS_DISABLE_HOST_VERIFICATION
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: POSTGRES_TLS_DISABLE_HOST_VERIFICATION
{{- end }}

{{/*
Renders the temporal.database.sqlTlsEnabled value
*/}}
{{- define "airbyte.temporal.database.sqlTlsEnabled" }}
    {{- ternary "true" "false" (eq .Values.global.database.type "external") }}
{{- end }}

{{/*
Renders the temporal.database.sqlTlsEnabled environment variable
*/}}
{{- define "airbyte.temporal.database.sqlTlsEnabled.env" }}
- name: SQL_TLS_ENABLED
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: SQL_TLS_ENABLED
{{- end }}

{{/*
Renders the temporal.database.sqlTlsDisableHostVerification value
*/}}
{{- define "airbyte.temporal.database.sqlTlsDisableHostVerification" }}
    {{- ternary "true" "false" (eq .Values.global.database.type "external") }}
{{- end }}

{{/*
Renders the temporal.database.sqlTlsDisableHostVerification environment variable
*/}}
{{- define "airbyte.temporal.database.sqlTlsDisableHostVerification.env" }}
- name: SQL_TLS_DISABLE_HOST_VERIFICATION
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: SQL_TLS_DISABLE_HOST_VERIFICATION
{{- end }}

{{/*
Renders the temporal.host value
*/}}
{{- define "airbyte.temporal.host" }}
    {{- (printf "%s-temporal:%d" .Release.Name (int .Values.temporal.service.port)) }}
{{- end }}

{{/*
Renders the temporal.host environment variable
*/}}
{{- define "airbyte.temporal.host.env" }}
- name: TEMPORAL_HOST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: TEMPORAL_HOST
{{- end }}

{{/*
Renders the temporal.configFilePath value
*/}}
{{- define "airbyte.temporal.configFilePath" }}
    {{- .Values.temporal.configFilePath | default "config/dynamicconfig/development.yaml" }}
{{- end }}

{{/*
Renders the temporal.configFilePath environment variable
*/}}
{{- define "airbyte.temporal.configFilePath.env" }}
- name: DYNAMIC_CONFIG_FILE_PATH
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DYNAMIC_CONFIG_FILE_PATH
{{- end }}

{{/*
Renders the set of all temporal environment variables
*/}}
{{- define "airbyte.temporal.envs" }}
{{- include "airbyte.temporal.autoSetup.env" . }}
{{- include "airbyte.temporal.database.engine.env" . }}
{{- include "airbyte.temporal.database.host.env" . }}
{{- include "airbyte.temporal.database.port.env" . }}
{{- include "airbyte.temporal.database.user.env" . }}
{{- include "airbyte.temporal.database.password.env" . }}
{{- include "airbyte.temporal.database.tlsEnabled.env" . }}
{{- include "airbyte.temporal.database.tlsDisableHostVerification.env" . }}
{{- include "airbyte.temporal.database.sqlTlsEnabled.env" . }}
{{- include "airbyte.temporal.database.sqlTlsDisableHostVerification.env" . }}
{{- include "airbyte.temporal.host.env" . }}
{{- include "airbyte.temporal.configFilePath.env" . }}
{{- end }}

{{/*
Renders the set of all temporal config map variables
*/}}
{{- define "airbyte.temporal.configVars" }}
AUTO_SETUP: {{ include "airbyte.temporal.autoSetup" . | quote }}
DB: {{ include "airbyte.temporal.database.engine" . | quote }}
POSTGRES_TLS_ENABLED: {{ include "airbyte.temporal.database.tlsEnabled" . | quote }}
POSTGRES_TLS_DISABLE_HOST_VERIFICATION: {{ include "airbyte.temporal.database.tlsDisableHostVerification" . | quote }}
SQL_TLS_ENABLED: {{ include "airbyte.temporal.database.sqlTlsEnabled" . | quote }}
SQL_TLS_DISABLE_HOST_VERIFICATION: {{ include "airbyte.temporal.database.sqlTlsDisableHostVerification" . | quote }}
TEMPORAL_HOST: {{ include "airbyte.temporal.host" . | quote }}
DYNAMIC_CONFIG_FILE_PATH: {{ include "airbyte.temporal.configFilePath" . | quote }}
{{- end }}

{{/*
Renders the temporal.cli secret name
*/}}
{{- define "airbyte.temporal.cli.secretName" }}
{{- if .Values.global.temporal.cli.secretName }}
    {{- .Values.global.temporal.cli.secretName }}
{{- else }}
    {{- .Release.Name }}-airbyte-secrets
{{- end }}
{{- end }}

{{/*
Renders the global.temporal.cli.address value
*/}}
{{- define "airbyte.temporal.cli.address" }}
    {{- .Values.global.temporal.cli.address }}
{{- end }}

{{/*
Renders the temporal.cli.address environment variable
*/}}
{{- define "airbyte.temporal.cli.address.env" }}
- name: TEMPORAL_CLI_ADDRESS
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: TEMPORAL_CLI_ADDRESS
{{- end }}

{{/*
Renders the global.temporal.cli.namespace value
*/}}
{{- define "airbyte.temporal.cli.namespace" }}
    {{- .Values.global.temporal.cli.namespace }}
{{- end }}

{{/*
Renders the temporal.cli.namespace environment variable
*/}}
{{- define "airbyte.temporal.cli.namespace.env" }}
- name: TEMPORAL_CLI_NAMESPACE
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: TEMPORAL_CLI_NAMESPACE
{{- end }}

{{/*
Renders the global.temporal.cli.tlsCert value
*/}}
{{- define "airbyte.temporal.cli.tlsCert" }}
    {{- .Values.global.temporal.cli.tlsCert }}
{{- end }}

{{/*
Renders the temporal.cli.tlsCert secret key
*/}}
{{- define "airbyte.temporal.cli.tlsCert.secretKey" }}
	{{- .Values.global.temporal.cli.tlsCertSecretKey | default "TEMPORAL_CLI_TLS_CERT" }}
{{- end }}

{{/*
Renders the temporal.cli.tlsCert environment variable
*/}}
{{- define "airbyte.temporal.cli.tlsCert.env" }}
- name: TEMPORAL_CLI_TLS_CERT
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.temporal.cli.secretName" . }}
      key: {{ include "airbyte.temporal.cli.tlsCert.secretKey" . }}
{{- end }}

{{/*
Renders the global.temporal.cli.tlsKey value
*/}}
{{- define "airbyte.temporal.cli.tlsKey" }}
    {{- .Values.global.temporal.cli.tlsKey }}
{{- end }}

{{/*
Renders the temporal.cli.tlsKey secret key
*/}}
{{- define "airbyte.temporal.cli.tlsKey.secretKey" }}
	{{- .Values.global.temporal.cli.tlsKeySecretKey | default "TEMPORAL_CLI_TLS_KEY" }}
{{- end }}

{{/*
Renders the temporal.cli.tlsKey environment variable
*/}}
{{- define "airbyte.temporal.cli.tlsKey.env" }}
- name: TEMPORAL_CLI_TLS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.temporal.cli.secretName" . }}
      key: {{ include "airbyte.temporal.cli.tlsKey.secretKey" . }}
{{- end }}

{{/*
Renders the set of all temporal.cli environment variables
*/}}
{{- define "airbyte.temporal.cli.envs" }}
{{- include "airbyte.temporal.cli.address.env" . }}
{{- include "airbyte.temporal.cli.namespace.env" . }}
{{- include "airbyte.temporal.cli.tlsCert.env" . }}
{{- include "airbyte.temporal.cli.tlsKey.env" . }}
{{- end }}

{{/*
Renders the set of all temporal.cli config map variables
*/}}
{{- define "airbyte.temporal.cli.configVars" }}
TEMPORAL_CLI_ADDRESS: {{ include "airbyte.temporal.cli.address" . | quote }}
TEMPORAL_CLI_NAMESPACE: {{ include "airbyte.temporal.cli.namespace" . | quote }}
{{- end }}

{{/*
Renders the set of all temporal.cli secret variables
*/}}
{{- define "airbyte.temporal.cli.secrets" }}
TEMPORAL_CLI_TLS_CERT: {{ include "airbyte.temporal.cli.tlsCert" . | quote }}
TEMPORAL_CLI_TLS_KEY: {{ include "airbyte.temporal.cli.tlsKey" . | quote }}
{{- end }}

{{/*
Renders the temporal.cloud secret name
*/}}
{{- define "airbyte.temporal.cloud.secretName" }}
{{- if .Values.global.temporal.cloud.secretName }}
    {{- .Values.global.temporal.cloud.secretName }}
{{- else }}
    {{- .Release.Name }}-airbyte-secrets
{{- end }}
{{- end }}

{{/*
Renders the global.temporal.cloud.enabled value
*/}}
{{- define "airbyte.temporal.cloud.enabled" }}
    {{- .Values.global.temporal.cloud.enabled | default false }}
{{- end }}

{{/*
Renders the temporal.cloud.enabled environment variable
*/}}
{{- define "airbyte.temporal.cloud.enabled.env" }}
- name: TEMPORAL_CLOUD_ENABLED
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: TEMPORAL_CLOUD_ENABLED
{{- end }}

{{/*
Renders the global.temporal.cloud.clientCert value
*/}}
{{- define "airbyte.temporal.cloud.clientCert" }}
    {{- .Values.global.temporal.cloud.clientCert }}
{{- end }}

{{/*
Renders the temporal.cloud.clientCert secret key
*/}}
{{- define "airbyte.temporal.cloud.clientCert.secretKey" }}
	{{- .Values.global.temporal.cloud.clientCertSecretKey | default "TEMPORAL_CLOUD_CLIENT_CERT" }}
{{- end }}

{{/*
Renders the temporal.cloud.clientCert environment variable
*/}}
{{- define "airbyte.temporal.cloud.clientCert.env" }}
- name: TEMPORAL_CLOUD_CLIENT_CERT
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.temporal.cloud.secretName" . }}
      key: {{ include "airbyte.temporal.cloud.clientCert.secretKey" . }}
{{- end }}

{{/*
Renders the global.temporal.cloud.clientKey value
*/}}
{{- define "airbyte.temporal.cloud.clientKey" }}
    {{- .Values.global.temporal.cloud.clientKey }}
{{- end }}

{{/*
Renders the temporal.cloud.clientKey secret key
*/}}
{{- define "airbyte.temporal.cloud.clientKey.secretKey" }}
	{{- .Values.global.temporal.cloud.clientKeySecretKey | default "TEMPORAL_CLOUD_CLIENT_KEY" }}
{{- end }}

{{/*
Renders the temporal.cloud.clientKey environment variable
*/}}
{{- define "airbyte.temporal.cloud.clientKey.env" }}
- name: TEMPORAL_CLOUD_CLIENT_KEY
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.temporal.cloud.secretName" . }}
      key: {{ include "airbyte.temporal.cloud.clientKey.secretKey" . }}
{{- end }}

{{/*
Renders the global.temporal.cloud.namespace value
*/}}
{{- define "airbyte.temporal.cloud.namespace" }}
    {{- .Values.global.temporal.cloud.namespace }}
{{- end }}

{{/*
Renders the temporal.cloud.namespace environment variable
*/}}
{{- define "airbyte.temporal.cloud.namespace.env" }}
- name: TEMPORAL_CLOUD_NAMESPACE
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: TEMPORAL_CLOUD_NAMESPACE
{{- end }}

{{/*
Renders the global.temporal.cloud.host value
*/}}
{{- define "airbyte.temporal.cloud.host" }}
    {{- .Values.global.temporal.cloud.host }}
{{- end }}

{{/*
Renders the temporal.cloud.host environment variable
*/}}
{{- define "airbyte.temporal.cloud.host.env" }}
- name: TEMPORAL_CLOUD_HOST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: TEMPORAL_CLOUD_HOST
{{- end }}

{{/*
Renders the set of all temporal.cloud environment variables
*/}}
{{- define "airbyte.temporal.cloud.envs" }}
{{- include "airbyte.temporal.cloud.enabled.env" . }}
{{- include "airbyte.temporal.cloud.clientCert.env" . }}
{{- include "airbyte.temporal.cloud.clientKey.env" . }}
{{- include "airbyte.temporal.cloud.namespace.env" . }}
{{- include "airbyte.temporal.cloud.host.env" . }}
{{- end }}

{{/*
Renders the set of all temporal.cloud config map variables
*/}}
{{- define "airbyte.temporal.cloud.configVars" }}
TEMPORAL_CLOUD_ENABLED: {{ include "airbyte.temporal.cloud.enabled" . | quote }}
TEMPORAL_CLOUD_NAMESPACE: {{ include "airbyte.temporal.cloud.namespace" . | quote }}
TEMPORAL_CLOUD_HOST: {{ include "airbyte.temporal.cloud.host" . | quote }}
{{- end }}

{{/*
Renders the set of all temporal.cloud secret variables
*/}}
{{- define "airbyte.temporal.cloud.secrets" }}
TEMPORAL_CLOUD_CLIENT_CERT: {{ include "airbyte.temporal.cloud.clientCert" . | quote }}
TEMPORAL_CLOUD_CLIENT_KEY: {{ include "airbyte.temporal.cloud.clientKey" . | quote }}
{{- end }}

{{/*
Renders the temporal.sdk.rpc.timeout value
*/}}
{{- define "airbyte.temporal.sdk.rpc.timeout" }}
    {{- .Values.temporal.sdk.rpc.timeout | default "120s" }}
{{- end }}

{{/*
Renders the temporal.sdk.rpc.timeout environment variable
*/}}
{{- define "airbyte.temporal.sdk.rpc.timeout.env" }}
- name: TEMPORAL_SDK_RPC_TIMEOUT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: TEMPORAL_SDK_RPC_TIMEOUT
{{- end }}

{{/*
Renders the temporal.sdk.rpc.longPollTimeout value
*/}}
{{- define "airbyte.temporal.sdk.rpc.longPollTimeout" }}
    {{- .Values.temporal.sdk.rpc.longPollTimeout | default "140s" }}
{{- end }}

{{/*
Renders the temporal.sdk.rpc.longPollTimeout environment variable
*/}}
{{- define "airbyte.temporal.sdk.rpc.longPollTimeout.env" }}
- name: TEMPORAL_SDK_RPC_LONG_POLL_TIMEOUT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: TEMPORAL_SDK_RPC_LONG_POLL_TIMEOUT
{{- end }}

{{/*
Renders the temporal.sdk.rpc.queryTimeout value
*/}}
{{- define "airbyte.temporal.sdk.rpc.queryTimeout" }}
    {{- .Values.temporal.sdk.rpc.queryTimeout | default "20s" }}
{{- end }}

{{/*
Renders the temporal.sdk.rpc.queryTimeout environment variable
*/}}
{{- define "airbyte.temporal.sdk.rpc.queryTimeout.env" }}
- name: TEMPORAL_SDK_RPC_QUERY_TIMEOUT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: TEMPORAL_SDK_RPC_QUERY_TIMEOUT
{{- end }}

{{/*
Renders the set of all temporal.sdk environment variables
*/}}
{{- define "airbyte.temporal.sdk.envs" }}
{{- include "airbyte.temporal.sdk.rpc.timeout.env" . }}
{{- include "airbyte.temporal.sdk.rpc.longPollTimeout.env" . }}
{{- include "airbyte.temporal.sdk.rpc.queryTimeout.env" . }}
{{- end }}

{{/*
Renders the set of all temporal.sdk config map variables
*/}}
{{- define "airbyte.temporal.sdk.configVars" }}
TEMPORAL_SDK_RPC_TIMEOUT: {{ include "airbyte.temporal.sdk.rpc.timeout" . | quote }}
TEMPORAL_SDK_RPC_LONG_POLL_TIMEOUT: {{ include "airbyte.temporal.sdk.rpc.longPollTimeout" . | quote }}
TEMPORAL_SDK_RPC_QUERY_TIMEOUT: {{ include "airbyte.temporal.sdk.rpc.queryTimeout" . | quote }}
{{- end }}

{{/*
Renders the temporal.worker.ports value
*/}}
{{- define "airbyte.temporal.worker.ports" }}
    {{- .Values.temporal.worker.ports }}
{{- end }}

{{/*
Renders the temporal.worker.ports environment variable
*/}}
{{- define "airbyte.temporal.worker.ports.env" }}
- name: TEMPORAL_WORKER_PORTS
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: TEMPORAL_WORKER_PORTS
{{- end }}

{{/*
Renders the set of all temporal.worker environment variables
*/}}
{{- define "airbyte.temporal.worker.envs" }}
{{- include "airbyte.temporal.worker.ports.env" . }}
{{- end }}

{{/*
Renders the set of all temporal.worker config map variables
*/}}
{{- define "airbyte.temporal.worker.configVars" }}
TEMPORAL_WORKER_PORTS: {{ include "airbyte.temporal.worker.ports" . | quote }}
{{- end }}
