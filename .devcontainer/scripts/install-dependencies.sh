#!/usr/bin/env bash

set -e

: "${K9S_VERSION:="v0.32.7"}"
: "${YQ_VERSION:="v4.44.5"}"

: "${CURL:="curl"}"
: "${WGET:="wget"}"

# https://k3d.io/v5.7.4/#installation
${CURL} -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
${CURL} -LO "https://dl.k8s.io/release/$(${CURL} -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  && chmod +x kubectl \
  && sudo mv kubectl /usr/local/bin/kubectl

# https://helm.sh/docs/intro/install/
${CURL} -s https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# https://github.com/derailed/k9s
${WGET} -q https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_linux_amd64.deb \
  && sudo apt-get -qyy install ./k9s_linux_amd64.deb \
  && rm k9s_linux_amd64.deb

# https://github.com/mikefarah/yq/releases
${WGET} -q https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 \
  && chmod +x yq_linux_amd64 \
  && sudo mv yq_linux_amd64 /usr/local/bin/yq
