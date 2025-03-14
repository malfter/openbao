#!/usr/bin/env bash

# Script overwrite openbao values in umbrella chart with values from original
# openbao project: https://github.com/openbao/openbao-helm

set -e

: "${CURL:="curl"}"
: "${YQ:="yq"}"

: "${OPENBAO_HELM_VERSION:=$(${YQ} '.dependencies[] | select(.name=="openbao") | .version' Chart.yaml)}"
: "${OPENBAO_VALUES_YAML_URL:="https://raw.githubusercontent.com/openbao/openbao-helm/refs/tags/openbao-${OPENBAO_HELM_VERSION}/charts/openbao/values.yaml"}"
: "${OUTPUT_FILE:="values.yaml"}"

# Download the remote YAML file content
OPENBAO_VALUES_YAML_ORIGIN=$(${CURL} -s "${OPENBAO_VALUES_YAML_URL}")
if [ $? -ne 0 ]; then
  echo "Error: Could not fetch ${OPENBAO_VALUES_YAML_URL}"
  exit 1
fi

# Add some meta informations to YAML content
OPENBAO_VALUES_YAML_INFO="# Origin of the values from: ${OPENBAO_VALUES_YAML_URL}\n# When updating the Openbao helm chart, script \`overrideValues.sh\` should be used to check for updated values.\n\n"
OPENBAO_VALUES_YAML=$(echo -e "${OPENBAO_VALUES_YAML_INFO}\n${OPENBAO_VALUES_YAML_ORIGIN}")

# Create a temporary file to hold the content with proper indentation
TEMP_FILE=$(mktemp)
trap "rm \"${TEMP_FILE}\"" EXIT
echo "${OPENBAO_VALUES_YAML}" | sed 's/^/  /' > "${TEMP_FILE}"

# Use yq to update or create the 'openbao' key with the entire content from the temporary file
${YQ} eval --inplace ".openbao = load(\"${TEMP_FILE}\")" "$OUTPUT_FILE"

echo "The file '${OUTPUT_FILE}' has been successfully updated with values from:"
echo "  ${OPENBAO_VALUES_YAML_URL}"
