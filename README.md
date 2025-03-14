# 🥟 openbao-playground

<img src="assets/openbao.svg" alt="OpenBao Logo" style="width: 150px;">

The project serves to take the first steps with [OpenBao](https://openbao.org/). Let's see where it leads... 🥳

## 📖 Table of Contents

- [🥟 openbao-playground](#-openbao-playground)
  - [📖 Table of Contents](#-table-of-contents)
  - [📌 Requirements](#-requirements)
  - [🌱 How to use](#-how-to-use)
    - [🛸 Install OpenBao in Dev Mode](#-install-openbao-in-dev-mode)
    - [🚀 Install OpenBao in HA Mode](#-install-openbao-in-ha-mode)
    - [🧽 Update OpenBao Installation](#-update-openbao-installation)
    - [🔧 Configure OpenBao Instance with OpenTofu](#-configure-openbao-instance-with-opentofu)
  - [🎮 Play around with the API](#-play-around-with-the-api)
  - [🔗 Further Links](#-further-links)

## 📌 Requirements

> ℹ️ If you don't want to install anything locally, you can also use the [devcontainer](.devcontainer/devcontainer.json) environment, which only requires a container runtime such as [podman](https://podman.io/)/[docker](https://docker.com).

To work with this project, you need to install some dependencies:

- [https://k3d.io]
- [https://helm.sh]
- [https://github.com/derailed/k9s]
- [https://github.com/mikefarah/yq]

## 🌱 How to use

Start a local Kubernetes runtime as a sandbox:

```bash
make local
```

To clean up and delete the Kubernetes cluster and all its resources, run:

```bash
make cleanup
```

### 🛸 Install OpenBao in Dev Mode

Install OpenBao in the Kubernetes cluster (ℹ️ The current k8s context is used!):

- [https://openbao.org/docs/concepts/dev-server/]

```bash
# Install openbao in kubernetes cluster (HA mode)
make install

# Get unseal key
kubectl logs -n openbao openbao-0 | grep "Unseal Key:" | cut -d' ' -f3
# Get root token
kubectl logs -n openbao openbao-0 | grep "Root Token:" | cut -d' ' -f3

# Unseal openbao
kubectl exec -n openbao -ti openbao-0 -- bao operator unseal

# Access OpenBao API, print seal and HA status
export VAULT_TOKEN=<ROOT_TOKEN>
./bao status

# Access OpenBao UI
open http://openbao-127.0.0.1.nip.io:8080/ui/
```

### 🚀 Install OpenBao in HA Mode

Install OpenBao in the Kubernetes cluster (ℹ️ The current k8s context is used!):

- [https://openbao.org/docs/concepts/ha/]

```bash
# Install openbao in kubernetes cluster (HA mode)
make install-ha

# Initialize and unseal openbao
kubectl exec -n openbao -ti openbao-0 -- bao operator init
kubectl exec -n openbao -ti openbao-0 -- bao operator unseal

# Join the remaining pods to the raft cluster and unseal them
kubectl exec -n openbao -ti openbao-1 -- bao operator raft join http://openbao-0.openbao-internal:8200
kubectl exec -n openbao -ti openbao-1 -- bao operator unseal

kubectl exec -n openbao -ti openbao-2 -- bao operator raft join http://openbao-0.openbao-internal:8200
kubectl exec -n openbao -ti openbao-2 -- bao operator unseal

# Login using root token
kubectl exec -n openbao -ti openbao-0 -- bao login

# List all the raft peers
kubectl exec -n openbao -ti openbao-0 -- bao operator raft list-peers

# Access OpenBao API, print seal and HA status
export VAULT_TOKEN=<ROOT_TOKEN>
./bao status

# Access OpenBao UI
open http://openbao-127.0.0.1.nip.io:8080/ui/
```

### 🧽 Update OpenBao Installation

```bash
cd charts/openbao

# Set new openbao-helm version
vi Chart.yaml

# Get the values from the new version and
# compare them to see if any adjustments need to be made.
# `git diff`
./overrideValues.sh
```

### 🔧 Configure OpenBao Instance with OpenTofu

An OpenTofu provider is available for OpenBao, which can be used to customise and configure an instance.

An OpenTofu configuration is available in the directory [config](./config/), which can be used to apply some sample configurations.

```bash
cd config

# Set VAULT_TOKEN for opentofu provider
export VAULT_TOKEN=root

./tofu init

./tofu apply
```

## 🎮 Play around with the API

Script [bao](./bao) can be used to play around a little with the API:

```bash
$ ./bao --help
Usage: bao <command> [args]

Common commands:
...

$ ./bao status
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         2.0.2
Build Date      2024-10-05T19:26:46Z
Storage Type    inmem
Cluster Name    vault-cluster-ed6f4ab3
Cluster ID      af9dde27-0153-c53e-272b-610ec1869058
HA Enabled      false
```

## 🔗 Further Links

- Project Direction & Roadmap
  - [https://openbao.org/blog/roadmap/]
  - [https://github.com/openbao/openbao/issues/569]
- Run OpenBao on Kubernetes
  - [https://openbao.org/docs/platform/k8s/helm/run/]
