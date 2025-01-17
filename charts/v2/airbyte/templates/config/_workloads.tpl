
{{/* DO NOT EDIT: This file was autogenerated. */}}

{{/*
    Workloads Configuration
*/}}

{{/*
Renders the workloads secret name
*/}}
{{- define "airbyte.workloads.secretName" }}
{{- if .Values.global.workloads.secretName }}
    {{- .Values.global.workloads.secretName }}
{{- else }}
    {{- .Release.Name }}-airbyte-secrets
{{- end }}
{{- end }}

{{/*
Renders the global.workloads.containerOrchestrator.secretName value
*/}}
{{- define "airbyte.workloads.containerOrchestrator.secretName" }}
    {{- include "airbyte.workloads.secretName" . }}
{{- end }}

{{/*
Renders the workloads.containerOrchestrator.secretName environment variable
*/}}
{{- define "airbyte.workloads.containerOrchestrator.secretName.env" }}
- name: CONTAINER_ORCHESTRATOR_SECRET_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: CONTAINER_ORCHESTRATOR_SECRET_NAME
{{- end }}

{{/*
Renders the global.workloads.containerOrchestrator.dataPlane.secretMountPath value
*/}}
{{- define "airbyte.workloads.containerOrchestrator.dataPlane.secretMountPath" }}
    {{- .Values.global.workloads.containerOrchestrator.dataPlane.secretMountPath | default "/secrets/dataplane-creds" }}
{{- end }}

{{/*
Renders the workloads.containerOrchestrator.dataPlane.secretMountPath environment variable
*/}}
{{- define "airbyte.workloads.containerOrchestrator.dataPlane.secretMountPath.env" }}
- name: CONTAINER_ORCHESTRATOR_DATA_PLANE_CREDS_SECRET_MOUNT_PATH
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: CONTAINER_ORCHESTRATOR_DATA_PLANE_CREDS_SECRET_MOUNT_PATH
{{- end }}

{{/*
Renders the global.workloads.containerOrchestrator.dataPlane.secretName value
*/}}
{{- define "airbyte.workloads.containerOrchestrator.dataPlane.secretName" }}
    {{- .Values.global.workloads.containerOrchestrator.dataPlane.secretName }}
{{- end }}

{{/*
Renders the workloads.containerOrchestrator.dataPlane.secretName environment variable
*/}}
{{- define "airbyte.workloads.containerOrchestrator.dataPlane.secretName.env" }}
- name: CONTAINER_ORCHESTRATOR_DATA_PLANE_CREDS_SECRET_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: CONTAINER_ORCHESTRATOR_DATA_PLANE_CREDS_SECRET_NAME
{{- end }}

{{/*
Renders the global.workloads.containerOrchestrator.javaOpts value
*/}}
{{- define "airbyte.workloads.containerOrchestrator.javaOpts" }}
    {{- .Values.global.workloads.containerOrchestrator.javaOpts | default "-XX:+ExitOnOutOfMemoryError -XX:MaxRAMPercentage=75.0 -javaagent:/app/dd-java-agent.jar -Ddd.profiling.enabled=true -XX:FlightRecorderOptions=stackdepth=256 -Ddd.trace.sample.rate=0.5 -Ddd.trace.request_header.tags=User-Agent:http.useragent" }}
{{- end }}

{{/*
Renders the workloads.containerOrchestrator.javaOpts environment variable
*/}}
{{- define "airbyte.workloads.containerOrchestrator.javaOpts.env" }}
- name: CONTAINER_ORCHESTRATOR_JAVA_OPTS
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: CONTAINER_ORCHESTRATOR_JAVA_OPTS
{{- end }}

{{/*
Renders the global.workloads.containerOrchestrator.secretMountPath value
*/}}
{{- define "airbyte.workloads.containerOrchestrator.secretMountPath" }}
    {{- .Values.global.workloads.containerOrchestrator.secretMountPath }}
{{- end }}

{{/*
Renders the workloads.containerOrchestrator.secretMountPath environment variable
*/}}
{{- define "airbyte.workloads.containerOrchestrator.secretMountPath.env" }}
- name: CONTAINER_ORCHESTRATOR_SECRET_MOUNT_PATH
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: CONTAINER_ORCHESTRATOR_SECRET_MOUNT_PATH
{{- end }}

{{/*
Renders the global.workloads.kubernetesClientMaxIdleConnections value
*/}}
{{- define "airbyte.workloads.kubernetesClientMaxIdleConnections" }}
    {{- .Values.global.workloads.kubernetesClientMaxIdleConnections | default 100 }}
{{- end }}

{{/*
Renders the workloads.kubernetesClientMaxIdleConnections environment variable
*/}}
{{- define "airbyte.workloads.kubernetesClientMaxIdleConnections.env" }}
- name: KUBERNETES_CLIENT_MAX_IDLE_CONNECTIONS
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: KUBERNETES_CLIENT_MAX_IDLE_CONNECTIONS
{{- end }}

{{/*
Renders the global.workloads.kuberentesClientMaxRetries value
*/}}
{{- define "airbyte.workloads.kuberentesClientMaxRetries" }}
    {{- .Values.global.workloads.kuberentesClientMaxRetries | default "" }}
{{- end }}

{{/*
Renders the workloads.kuberentesClientMaxRetries environment variable
*/}}
{{- define "airbyte.workloads.kuberentesClientMaxRetries.env" }}
- name: KUBERNETES_CLIENT_MAX_RETRIES
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: KUBERNETES_CLIENT_MAX_RETRIES
{{- end }}

{{/*
Renders the global.workloads.pubSub.enabled value
*/}}
{{- define "airbyte.workloads.pubSub.enabled" }}
    {{- .Values.global.workloads.pubSub.enabled | default false }}
{{- end }}

{{/*
Renders the workloads.pubSub.enabled environment variable
*/}}
{{- define "airbyte.workloads.pubSub.enabled.env" }}
- name: PUB_SUB_ENABLED
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: PUB_SUB_ENABLED
{{- end }}

{{/*
Renders the global.workloads.pubSub.topicName value
*/}}
{{- define "airbyte.workloads.pubSub.topicName" }}
    {{- .Values.global.workloads.pubSub.topicName | default "" }}
{{- end }}

{{/*
Renders the workloads.pubSub.topicName environment variable
*/}}
{{- define "airbyte.workloads.pubSub.topicName.env" }}
- name: PUB_SUB_TOPIC_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: PUB_SUB_TOPIC_NAME
{{- end }}

{{/*
Renders the set of all workloads environment variables
*/}}
{{- define "airbyte.workloads.envs" }}
{{- include "airbyte.workloads.containerOrchestrator.secretName.env" . }}
{{- include "airbyte.workloads.containerOrchestrator.dataPlane.secretMountPath.env" . }}
{{- include "airbyte.workloads.containerOrchestrator.dataPlane.secretName.env" . }}
{{- include "airbyte.workloads.containerOrchestrator.javaOpts.env" . }}
{{- include "airbyte.workloads.containerOrchestrator.secretMountPath.env" . }}
{{- include "airbyte.workloads.kubernetesClientMaxIdleConnections.env" . }}
{{- include "airbyte.workloads.kuberentesClientMaxRetries.env" . }}
{{- include "airbyte.workloads.pubSub.enabled.env" . }}
{{- include "airbyte.workloads.pubSub.topicName.env" . }}
{{- end }}

{{/*
Renders the set of all workloads config map variables
*/}}
{{- define "airbyte.workloads.configVars" }}
CONTAINER_ORCHESTRATOR_SECRET_NAME: {{ include "airbyte.workloads.containerOrchestrator.secretName" . | quote }}
CONTAINER_ORCHESTRATOR_DATA_PLANE_CREDS_SECRET_MOUNT_PATH: {{ include "airbyte.workloads.containerOrchestrator.dataPlane.secretMountPath" . | quote }}
CONTAINER_ORCHESTRATOR_DATA_PLANE_CREDS_SECRET_NAME: {{ include "airbyte.workloads.containerOrchestrator.dataPlane.secretName" . | quote }}
CONTAINER_ORCHESTRATOR_JAVA_OPTS: {{ include "airbyte.workloads.containerOrchestrator.javaOpts" . | quote }}
CONTAINER_ORCHESTRATOR_SECRET_MOUNT_PATH: {{ include "airbyte.workloads.containerOrchestrator.secretMountPath" . | quote }}
KUBERNETES_CLIENT_MAX_IDLE_CONNECTIONS: {{ include "airbyte.workloads.kubernetesClientMaxIdleConnections" . | quote }}
KUBERNETES_CLIENT_MAX_RETRIES: {{ include "airbyte.workloads.kuberentesClientMaxRetries" . | quote }}
PUB_SUB_ENABLED: {{ include "airbyte.workloads.pubSub.enabled" . | quote }}
PUB_SUB_TOPIC_NAME: {{ include "airbyte.workloads.pubSub.topicName" . | quote }}
{{- end }}

{{/*
Renders the workloads.queues secret name
*/}}
{{- define "airbyte.workloads.queues.secretName" }}
{{- if .Values.global.workloads.queues.secretName }}
    {{- .Values.global.workloads.queues.secretName }}
{{- else }}
    {{- .Release.Name }}-airbyte-secrets
{{- end }}
{{- end }}

{{/*
Renders the global.workloads.queues.check value
*/}}
{{- define "airbyte.workloads.queues.check" }}
    {{- join " " .Values.global.workloads.queues.check }}
{{- end }}

{{/*
Renders the workloads.queues.check environment variable
*/}}
{{- define "airbyte.workloads.queues.check.env" }}
- name: DATA_CHECK_TASK_QUEUES
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DATA_CHECK_TASK_QUEUES
{{- end }}

{{/*
Renders the global.workloads.queues.discover value
*/}}
{{- define "airbyte.workloads.queues.discover" }}
    {{- join " " .Values.global.workloads.queues.discover }}
{{- end }}

{{/*
Renders the workloads.queues.discover environment variable
*/}}
{{- define "airbyte.workloads.queues.discover.env" }}
- name: DATA_DISCOVER_TASK_QUEUES
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DATA_DISCOVER_TASK_QUEUES
{{- end }}

{{/*
Renders the global.workloads.queues.sync value
*/}}
{{- define "airbyte.workloads.queues.sync" }}
    {{- join " " .Values.global.workloads.queues.sync }}
{{- end }}

{{/*
Renders the workloads.queues.sync environment variable
*/}}
{{- define "airbyte.workloads.queues.sync.env" }}
- name: DATA_SYNC_TASK_QUEUES
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DATA_SYNC_TASK_QUEUES
{{- end }}

{{/*
Renders the set of all workloads.queues environment variables
*/}}
{{- define "airbyte.workloads.queues.envs" }}
{{- include "airbyte.workloads.queues.check.env" . }}
{{- include "airbyte.workloads.queues.discover.env" . }}
{{- include "airbyte.workloads.queues.sync.env" . }}
{{- end }}

{{/*
Renders the set of all workloads.queues config map variables
*/}}
{{- define "airbyte.workloads.queues.configVars" }}
DATA_CHECK_TASK_QUEUES: {{ include "airbyte.workloads.queues.check" . | quote }}
DATA_DISCOVER_TASK_QUEUES: {{ include "airbyte.workloads.queues.discover" . | quote }}
DATA_SYNC_TASK_QUEUES: {{ include "airbyte.workloads.queues.sync" . | quote }}
{{- end }}

{{/*
Renders the workloads.resources secret name
*/}}
{{- define "airbyte.workloads.resources.secretName" }}
{{- if .Values.global.workloads.resources.secretName }}
    {{- .Values.global.workloads.resources.secretName }}
{{- else }}
    {{- .Release.Name }}-airbyte-secrets
{{- end }}
{{- end }}

{{/*
Renders the global.workloads.resources.useConnectorResourceDefaults value
*/}}
{{- define "airbyte.workloads.resources.useConnectorResourceDefaults" }}
    {{- .Values.global.workloads.resources.useConnectorResourceDefaults | default true }}
{{- end }}

{{/*
Renders the workloads.resources.useConnectorResourceDefaults environment variable
*/}}
{{- define "airbyte.workloads.resources.useConnectorResourceDefaults.env" }}
- name: CONNECTOR_SPECIFIC_RESOURCE_DEFAULTS_ENABLED
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: CONNECTOR_SPECIFIC_RESOURCE_DEFAULTS_ENABLED
{{- end }}

{{/*
Renders the global.workloads.resources.mainContainer.cpu.limit value
*/}}
{{- define "airbyte.workloads.resources.mainContainer.cpu.limit" }}
    {{- .Values.global.workloads.resources.mainContainer.cpu.limit | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.mainContainer.cpu.limit environment variable
*/}}
{{- define "airbyte.workloads.resources.mainContainer.cpu.limit.env" }}
- name: JOB_MAIN_CONTAINER_CPU_LIMIT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: JOB_MAIN_CONTAINER_CPU_LIMIT
{{- end }}

{{/*
Renders the global.workloads.resources.mainContainer.cpu.request value
*/}}
{{- define "airbyte.workloads.resources.mainContainer.cpu.request" }}
    {{- .Values.global.workloads.resources.mainContainer.cpu.request | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.mainContainer.cpu.request environment variable
*/}}
{{- define "airbyte.workloads.resources.mainContainer.cpu.request.env" }}
- name: JOB_MAIN_CONTAINER_CPU_REQUEST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: JOB_MAIN_CONTAINER_CPU_REQUEST
{{- end }}

{{/*
Renders the global.workloads.resources.mainContainer.memory.limit value
*/}}
{{- define "airbyte.workloads.resources.mainContainer.memory.limit" }}
    {{- .Values.global.workloads.resources.mainContainer.memory.limit | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.mainContainer.memory.limit environment variable
*/}}
{{- define "airbyte.workloads.resources.mainContainer.memory.limit.env" }}
- name: JOB_MAIN_CONTAINER_MEMORY_LIMIT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: JOB_MAIN_CONTAINER_MEMORY_LIMIT
{{- end }}

{{/*
Renders the global.workloads.resources.mainContainer.memory.request value
*/}}
{{- define "airbyte.workloads.resources.mainContainer.memory.request" }}
    {{- .Values.global.workloads.resources.mainContainer.memory.request | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.mainContainer.memory.request environment variable
*/}}
{{- define "airbyte.workloads.resources.mainContainer.memory.request.env" }}
- name: JOB_MAIN_CONTAINER_MEMORY_REQUEST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: JOB_MAIN_CONTAINER_MEMORY_REQUEST
{{- end }}

{{/*
Renders the global.workloads.resources.check.cpu.limit value
*/}}
{{- define "airbyte.workloads.resources.check.cpu.limit" }}
    {{- .Values.global.workloads.resources.check.cpu.limit | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.check.cpu.limit environment variable
*/}}
{{- define "airbyte.workloads.resources.check.cpu.limit.env" }}
- name: CHECK_JOB_MAIN_CONTAINER_CPU_LIMIT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: CHECK_JOB_MAIN_CONTAINER_CPU_LIMIT
{{- end }}

{{/*
Renders the global.workloads.resources.check.cpu.request value
*/}}
{{- define "airbyte.workloads.resources.check.cpu.request" }}
    {{- .Values.global.workloads.resources.check.cpu.request | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.check.cpu.request environment variable
*/}}
{{- define "airbyte.workloads.resources.check.cpu.request.env" }}
- name: CHECK_JOB_MAIN_CONTAINER_CPU_REQUEST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: CHECK_JOB_MAIN_CONTAINER_CPU_REQUEST
{{- end }}

{{/*
Renders the global.workloads.resources.check.memory.limit value
*/}}
{{- define "airbyte.workloads.resources.check.memory.limit" }}
    {{- .Values.global.workloads.resources.check.memory.limit | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.check.memory.limit environment variable
*/}}
{{- define "airbyte.workloads.resources.check.memory.limit.env" }}
- name: CHECK_JOB_MAIN_CONTAINER_MEMORY_LIMIT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: CHECK_JOB_MAIN_CONTAINER_MEMORY_LIMIT
{{- end }}

{{/*
Renders the global.workloads.resources.check.memory.request value
*/}}
{{- define "airbyte.workloads.resources.check.memory.request" }}
    {{- .Values.global.workloads.resources.check.memory.request | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.check.memory.request environment variable
*/}}
{{- define "airbyte.workloads.resources.check.memory.request.env" }}
- name: CHECK_JOB_MAIN_CONTAINER_MEMORY_REQUEST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: CHECK_JOB_MAIN_CONTAINER_MEMORY_REQUEST
{{- end }}

{{/*
Renders the global.workloads.resources.discover.cpu.limit value
*/}}
{{- define "airbyte.workloads.resources.discover.cpu.limit" }}
    {{- .Values.global.workloads.resources.discover.cpu.limit | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.discover.cpu.limit environment variable
*/}}
{{- define "airbyte.workloads.resources.discover.cpu.limit.env" }}
- name: DISCOVER_JOB_MAIN_CONTAINER_CPU_LIMIT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DISCOVER_JOB_MAIN_CONTAINER_CPU_LIMIT
{{- end }}

{{/*
Renders the global.workloads.resources.discover.cpu.request value
*/}}
{{- define "airbyte.workloads.resources.discover.cpu.request" }}
    {{- .Values.global.workloads.resources.discover.cpu.request | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.discover.cpu.request environment variable
*/}}
{{- define "airbyte.workloads.resources.discover.cpu.request.env" }}
- name: DISCOVER_JOB_MAIN_CONTAINER_CPU_REQUEST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DISCOVER_JOB_MAIN_CONTAINER_CPU_REQUEST
{{- end }}

{{/*
Renders the global.workloads.resources.discover.memory.limit value
*/}}
{{- define "airbyte.workloads.resources.discover.memory.limit" }}
    {{- .Values.global.workloads.resources.discover.memory.limit | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.discover.memory.limit environment variable
*/}}
{{- define "airbyte.workloads.resources.discover.memory.limit.env" }}
- name: DISCOVER_JOB_MAIN_CONTAINER_MEMORY_LIMIT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DISCOVER_JOB_MAIN_CONTAINER_MEMORY_LIMIT
{{- end }}

{{/*
Renders the global.workloads.resources.discover.memory.request value
*/}}
{{- define "airbyte.workloads.resources.discover.memory.request" }}
    {{- .Values.global.workloads.resources.discover.memory.request | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.discover.memory.request environment variable
*/}}
{{- define "airbyte.workloads.resources.discover.memory.request.env" }}
- name: DISCOVER_JOB_MAIN_CONTAINER_MEMORY_REQUEST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DISCOVER_JOB_MAIN_CONTAINER_MEMORY_REQUEST
{{- end }}

{{/*
Renders the global.workloads.resources.fileTransfer.storage.limit value
*/}}
{{- define "airbyte.workloads.resources.fileTransfer.storage.limit" }}
    {{- .Values.global.workloads.resources.fileTransfer.storage.limit | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.fileTransfer.storage.limit environment variable
*/}}
{{- define "airbyte.workloads.resources.fileTransfer.storage.limit.env" }}
- name: FILE_TRANSFER_EPHEMERAL_STORAGE_LIMIT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: FILE_TRANSFER_EPHEMERAL_STORAGE_LIMIT
{{- end }}

{{/*
Renders the global.workloads.resources.fileTransfer.storage.request value
*/}}
{{- define "airbyte.workloads.resources.fileTransfer.storage.request" }}
    {{- .Values.global.workloads.resources.fileTransfer.storage.request | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.fileTransfer.storage.request environment variable
*/}}
{{- define "airbyte.workloads.resources.fileTransfer.storage.request.env" }}
- name: FILE_TRANSFER_EPHEMERAL_STORAGE_REQUEST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: FILE_TRANSFER_EPHEMERAL_STORAGE_REQUEST
{{- end }}

{{/*
Renders the global.workloads.resources.replication.cpu.limit value
*/}}
{{- define "airbyte.workloads.resources.replication.cpu.limit" }}
    {{- .Values.global.workloads.resources.replication.cpu.limit | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.replication.cpu.limit environment variable
*/}}
{{- define "airbyte.workloads.resources.replication.cpu.limit.env" }}
- name: REPLICATION_ORCHESTRATOR_CPU_LIMIT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: REPLICATION_ORCHESTRATOR_CPU_LIMIT
{{- end }}

{{/*
Renders the global.workloads.resources.replication.cpu.request value
*/}}
{{- define "airbyte.workloads.resources.replication.cpu.request" }}
    {{- .Values.global.workloads.resources.replication.cpu.request | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.replication.cpu.request environment variable
*/}}
{{- define "airbyte.workloads.resources.replication.cpu.request.env" }}
- name: REPLICATION_ORCHESTRATOR_CPU_REQUEST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: REPLICATION_ORCHESTRATOR_CPU_REQUEST
{{- end }}

{{/*
Renders the global.workloads.resources.replication.memory.limit value
*/}}
{{- define "airbyte.workloads.resources.replication.memory.limit" }}
    {{- .Values.global.workloads.resources.replication.memory.limit | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.replication.memory.limit environment variable
*/}}
{{- define "airbyte.workloads.resources.replication.memory.limit.env" }}
- name: REPLICATION_ORCHESTRATOR_MEMORY_LIMIT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: REPLICATION_ORCHESTRATOR_MEMORY_LIMIT
{{- end }}

{{/*
Renders the global.workloads.resources.replication.memory.request value
*/}}
{{- define "airbyte.workloads.resources.replication.memory.request" }}
    {{- .Values.global.workloads.resources.replication.memory.request | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.replication.memory.request environment variable
*/}}
{{- define "airbyte.workloads.resources.replication.memory.request.env" }}
- name: REPLICATION_ORCHESTRATOR_MEMORY_REQUEST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: REPLICATION_ORCHESTRATOR_MEMORY_REQUEST
{{- end }}

{{/*
Renders the global.workloads.resources.sidecar.cpu.limit value
*/}}
{{- define "airbyte.workloads.resources.sidecar.cpu.limit" }}
    {{- .Values.global.workloads.resources.sidecar.cpu.limit | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.sidecar.cpu.limit environment variable
*/}}
{{- define "airbyte.workloads.resources.sidecar.cpu.limit.env" }}
- name: SIDECAR_MAIN_CONTAINER_CPU_LIMIT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: SIDECAR_MAIN_CONTAINER_CPU_LIMIT
{{- end }}

{{/*
Renders the global.workloads.resources.sidecar.cpu.request value
*/}}
{{- define "airbyte.workloads.resources.sidecar.cpu.request" }}
    {{- .Values.global.workloads.resources.sidecar.cpu.request | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.sidecar.cpu.request environment variable
*/}}
{{- define "airbyte.workloads.resources.sidecar.cpu.request.env" }}
- name: SIDECAR_MAIN_CONTAINER_CPU_REQUEST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: SIDECAR_MAIN_CONTAINER_CPU_REQUEST
{{- end }}

{{/*
Renders the global.workloads.resources.sidecar.memory.limit value
*/}}
{{- define "airbyte.workloads.resources.sidecar.memory.limit" }}
    {{- .Values.global.workloads.resources.sidecar.memory.limit | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.sidecar.memory.limit environment variable
*/}}
{{- define "airbyte.workloads.resources.sidecar.memory.limit.env" }}
- name: SIDECAR_MAIN_CONTAINER_MEMORY_LIMIT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: SIDECAR_MAIN_CONTAINER_MEMORY_LIMIT
{{- end }}

{{/*
Renders the global.workloads.resources.sidecar.memory.request value
*/}}
{{- define "airbyte.workloads.resources.sidecar.memory.request" }}
    {{- .Values.global.workloads.resources.sidecar.memory.request | default "" }}
{{- end }}

{{/*
Renders the workloads.resources.sidecar.memory.request environment variable
*/}}
{{- define "airbyte.workloads.resources.sidecar.memory.request.env" }}
- name: SIDECAR_MAIN_CONTAINER_MEMORY_REQUEST
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: SIDECAR_MAIN_CONTAINER_MEMORY_REQUEST
{{- end }}

{{/*
Renders the set of all workloads.resources environment variables
*/}}
{{- define "airbyte.workloads.resources.envs" }}
{{- include "airbyte.workloads.resources.useConnectorResourceDefaults.env" . }}
{{- include "airbyte.workloads.resources.mainContainer.cpu.limit.env" . }}
{{- include "airbyte.workloads.resources.mainContainer.cpu.request.env" . }}
{{- include "airbyte.workloads.resources.mainContainer.memory.limit.env" . }}
{{- include "airbyte.workloads.resources.mainContainer.memory.request.env" . }}
{{- include "airbyte.workloads.resources.check.cpu.limit.env" . }}
{{- include "airbyte.workloads.resources.check.cpu.request.env" . }}
{{- include "airbyte.workloads.resources.check.memory.limit.env" . }}
{{- include "airbyte.workloads.resources.check.memory.request.env" . }}
{{- include "airbyte.workloads.resources.discover.cpu.limit.env" . }}
{{- include "airbyte.workloads.resources.discover.cpu.request.env" . }}
{{- include "airbyte.workloads.resources.discover.memory.limit.env" . }}
{{- include "airbyte.workloads.resources.discover.memory.request.env" . }}
{{- include "airbyte.workloads.resources.fileTransfer.storage.limit.env" . }}
{{- include "airbyte.workloads.resources.fileTransfer.storage.request.env" . }}
{{- include "airbyte.workloads.resources.replication.cpu.limit.env" . }}
{{- include "airbyte.workloads.resources.replication.cpu.request.env" . }}
{{- include "airbyte.workloads.resources.replication.memory.limit.env" . }}
{{- include "airbyte.workloads.resources.replication.memory.request.env" . }}
{{- include "airbyte.workloads.resources.sidecar.cpu.limit.env" . }}
{{- include "airbyte.workloads.resources.sidecar.cpu.request.env" . }}
{{- include "airbyte.workloads.resources.sidecar.memory.limit.env" . }}
{{- include "airbyte.workloads.resources.sidecar.memory.request.env" . }}
{{- end }}

{{/*
Renders the set of all workloads.resources config map variables
*/}}
{{- define "airbyte.workloads.resources.configVars" }}
CONNECTOR_SPECIFIC_RESOURCE_DEFAULTS_ENABLED: {{ include "airbyte.workloads.resources.useConnectorResourceDefaults" . | quote }}
JOB_MAIN_CONTAINER_CPU_LIMIT: {{ include "airbyte.workloads.resources.mainContainer.cpu.limit" . | quote }}
JOB_MAIN_CONTAINER_CPU_REQUEST: {{ include "airbyte.workloads.resources.mainContainer.cpu.request" . | quote }}
JOB_MAIN_CONTAINER_MEMORY_LIMIT: {{ include "airbyte.workloads.resources.mainContainer.memory.limit" . | quote }}
JOB_MAIN_CONTAINER_MEMORY_REQUEST: {{ include "airbyte.workloads.resources.mainContainer.memory.request" . | quote }}
CHECK_JOB_MAIN_CONTAINER_CPU_LIMIT: {{ include "airbyte.workloads.resources.check.cpu.limit" . | quote }}
CHECK_JOB_MAIN_CONTAINER_CPU_REQUEST: {{ include "airbyte.workloads.resources.check.cpu.request" . | quote }}
CHECK_JOB_MAIN_CONTAINER_MEMORY_LIMIT: {{ include "airbyte.workloads.resources.check.memory.limit" . | quote }}
CHECK_JOB_MAIN_CONTAINER_MEMORY_REQUEST: {{ include "airbyte.workloads.resources.check.memory.request" . | quote }}
DISCOVER_JOB_MAIN_CONTAINER_CPU_LIMIT: {{ include "airbyte.workloads.resources.discover.cpu.limit" . | quote }}
DISCOVER_JOB_MAIN_CONTAINER_CPU_REQUEST: {{ include "airbyte.workloads.resources.discover.cpu.request" . | quote }}
DISCOVER_JOB_MAIN_CONTAINER_MEMORY_LIMIT: {{ include "airbyte.workloads.resources.discover.memory.limit" . | quote }}
DISCOVER_JOB_MAIN_CONTAINER_MEMORY_REQUEST: {{ include "airbyte.workloads.resources.discover.memory.request" . | quote }}
FILE_TRANSFER_EPHEMERAL_STORAGE_LIMIT: {{ include "airbyte.workloads.resources.fileTransfer.storage.limit" . | quote }}
FILE_TRANSFER_EPHEMERAL_STORAGE_REQUEST: {{ include "airbyte.workloads.resources.fileTransfer.storage.request" . | quote }}
REPLICATION_ORCHESTRATOR_CPU_LIMIT: {{ include "airbyte.workloads.resources.replication.cpu.limit" . | quote }}
REPLICATION_ORCHESTRATOR_CPU_REQUEST: {{ include "airbyte.workloads.resources.replication.cpu.request" . | quote }}
REPLICATION_ORCHESTRATOR_MEMORY_LIMIT: {{ include "airbyte.workloads.resources.replication.memory.limit" . | quote }}
REPLICATION_ORCHESTRATOR_MEMORY_REQUEST: {{ include "airbyte.workloads.resources.replication.memory.request" . | quote }}
SIDECAR_MAIN_CONTAINER_CPU_LIMIT: {{ include "airbyte.workloads.resources.sidecar.cpu.limit" . | quote }}
SIDECAR_MAIN_CONTAINER_CPU_REQUEST: {{ include "airbyte.workloads.resources.sidecar.cpu.request" . | quote }}
SIDECAR_MAIN_CONTAINER_MEMORY_LIMIT: {{ include "airbyte.workloads.resources.sidecar.memory.limit" . | quote }}
SIDECAR_MAIN_CONTAINER_MEMORY_REQUEST: {{ include "airbyte.workloads.resources.sidecar.memory.request" . | quote }}
{{- end }}
