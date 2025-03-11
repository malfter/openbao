.DEFAULT_GOAL := help

KEYCLOAK_HELM_NAME := keycloak
KEYCLOAK_HELM_PATH := charts/keycloak/
KEYCLOAK_HELM_VALUES := charts/keycloak/values.yaml
KEYCLOAK_NAMESPACE := keycloak

OPENBAO_HELM_NAME := openbao
OPENBAO_HELM_PATH := charts/openbao/
OPENBAO_HELM_VALUES := charts/openbao/override-values.yaml
OPENBAO_HELM_VALUES_HA := charts/openbao/override-values-ha.yaml
OPENBAO_NAMESPACE := openbao

.PHONY: help
help:  ## 💬 This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: local
local:  ## 🏗️  Create local kubernetes environment with k3d
	# Fix Pods evicted due to lack of disk space
	# https://k3d.io/v5.4.6/faq/faq/#pods-evicted-due-to-lack-of-disk-space
	k3d cluster create --config ./.k3d/cluster.yaml \
  		--k3s-arg '--kubelet-arg=eviction-hard=imagefs.available<1%,nodefs.available<1%@agent:*' \
  		--k3s-arg '--kubelet-arg=eviction-minimum-reclaim=imagefs.available=1%,nodefs.available=1%@agent:*'

.PHONY: helm
helm:  ## 📦 Add helm repositories
	helm repo add openbao https://openbao.github.io/openbao-helm
	helm repo add hashicorp https://helm.releases.hashicorp.com

.PHONY: install
install: helm  ## 🚀 Install OpenBao in 'dev' mode in kubernetes cluster
	helm dependency update $(OPENBAO_HELM_PATH)
	helm dependency build $(OPENBAO_HELM_PATH)
	helm upgrade --install \
		--create-namespace \
		--namespace $(OPENBAO_NAMESPACE) \
		-f $(OPENBAO_HELM_VALUES) \
		$(OPENBAO_HELM_NAME) \
		$(OPENBAO_HELM_PATH)

.PHONY: install-ha
install-ha: helm  ## 🚀 Install OpenBao in 'ha' mode in kubernetes cluster
	helm dependency update $(OPENBAO_HELM_PATH)
	helm dependency build $(OPENBAO_HELM_PATH)
	helm upgrade --install \
		--create-namespace \
		--namespace $(OPENBAO_NAMESPACE) \
		-f $(OPENBAO_HELM_VALUES) -f $(OPENBAO_HELM_VALUES_HA) \
		$(OPENBAO_HELM_NAME) \
		$(OPENBAO_HELM_PATH)

.PHONY: keycloak
keycloak: helm  ## 🆔 Install Keycloak as Idenity Provider
	helm dependency update $(KEYCLOAK_HELM_PATH)
	helm dependency build $(KEYCLOAK_HELM_PATH)
	helm upgrade --install \
		--create-namespace \
		--namespace $(KEYCLOAK_NAMESPACE) \
		-f $(KEYCLOAK_HELM_VALUES) \
		$(KEYCLOAK_HELM_NAME) \
		$(KEYCLOAK_HELM_PATH)

.PHONY: uninstall
uninstall:  ## 🗑️  Uninstall applications in kubernetes cluster
	helm uninstall \
		--namespace $(OPENBAO_NAMESPACE) \
		$(OPENBAO_HELM_NAME)

.PHONY: cleanup
cleanup:  ## 🧹 Clean up project
	k3d cluster delete --config ./.k3d/cluster.yaml
