# Cluster Octopus

Cluster Octopus controls all necessary access to ensure your Kubernetes Cluster is functioning correctly.

## Introduction

This chart deploys Cluster Octopus on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm repo add cluster-octopus https://cgtysylr.github.io/cluster-octopus
helm install my-release cluster-octopus/cluster-octopus
```

The command deploys Cluster Octopus on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm uninstall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |

### Common parameters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| `nameOverride`           | String to partially override cluster-octopus.fullname template with a string (will prepend the release name) | `""` |
| `fullnameOverride`       | String to fully override cluster-octopus.fullname template with a string                    | `""`            |

### Image parameters

| Name                | Description                                                                                  | Value                        |
| ------------------- | -------------------------------------------------------------------------------------------- | ---------------------------- |
| `image.repository`  | Cluster Octopus image repository                                                             | `cgtysylr/cluster-octopus`   |
| `image.tag`         | Cluster Octopus image tag (immutable tags are recommended)                                  | `"1.0.0"`                    |
| `image.pullPolicy`  | Image pull policy                                                                             | `IfNotPresent`               |

### Namespace parameters

| Name                    | Description                                                                                  | Value              |
| ----------------------- | -------------------------------------------------------------------------------------------- | ------------------ |
| `namespace.create`      | Enable namespace creation                                                                    | `true`             |
| `namespace.name`        | Name of the namespace to create                                                              | `cluster-octopus`  |

### ServiceAccount parameters

| Name                           | Description                                                                                  | Value   |
| ------------------------------ | -------------------------------------------------------------------------------------------- | ------- |
| `serviceAccount.create`        | Enable creation of ServiceAccount for Cluster Octopus pods                                  | `true`  |
| `serviceAccount.name`          | The name of the ServiceAccount to use                                                        | `""`    |
| `serviceAccount.automount`     | Automount API credentials for the Service Account                                            | `true`  |
| `serviceAccount.annotations`   | Additional custom annotations for the ServiceAccount                                         | `{}`    |

### Pod parameters

| Name                    | Description                                                                                  | Value   |
| ----------------------- | -------------------------------------------------------------------------------------------- | ------- |
| `podAnnotations`        | Pod annotations                                                                              | `{}`    |
| `podLabels`             | Pod labels                                                                                   | `{}`    |
| `podSecurityContext`    | Pod Security Context                                                                         | `{}`    |
| `securityContext`       | Container Security Context                                                                   | `{}`    |

### Service parameters

| Name                    | Description                                                                                  | Value        |
| ----------------------- | -------------------------------------------------------------------------------------------- | ------------ |
| `service.type`          | Kubernetes service type                                                                      | `ClusterIP`  |
| `service.port`          | Kubernetes service port                                                                      | `80`         |
| `service.targetPort`    | Kubernetes service target port                                                               | `80`         |
| `service.annotations`   | Additional custom annotations for the service                                               | `{}`         |

### Ingress parameters

| Name                    | Description                                                                                  | Value   |
| ----------------------- | -------------------------------------------------------------------------------------------- | ------- |
| `ingress.enabled`       | Enable ingress record generation for Cluster Octopus                                        | `false` |
| `ingress.className`     | IngressClass that will be be used to implement the Ingress                                  | `""`    |
| `ingress.annotations`   | Additional annotations for the Ingress resource                                             | `{}`    |
| `ingress.hosts`         | An array that will be used to create Ingress resource                                       | `[]`    |
| `ingress.tls`           | TLS configuration for Ingress                                                               | `[]`    |

### Persistence parameters

| Name                        | Description                                                                                  | Value               |
| --------------------------- | -------------------------------------------------------------------------------------------- | ------------------- |
| `persistence.enabled`       | Enable persistence using Persistent Volume Claims                                           | `true`              |
| `persistence.storageClass`  | Storage class of backing PVC                                                                | `""`                |
| `persistence.accessMode`    | Access mode for the volume                                                                   | `ReadWriteMany`     |
| `persistence.size`          | Size of data volume                                                                          | `10Gi`              |
| `persistence.mountPath`     | Path to mount the volume at                                                                  | `/nfsdata/data`     |
| `persistence.subPath`       | Sub-path of the volume to mount                                                              | `cluster-octopus`   |

### Database parameters

| Name                    | Description                                                                                  | Value                    |
| ----------------------- | -------------------------------------------------------------------------------------------- | ------------------------ |
| `database.connection`   | Database connection type                                                                     | `pgsql`                  |
| `database.host`         | Database host                                                                                | `10.15.50.36`            |
| `database.port`         | Database port                                                                                | `5432`                   |
| `database.database`     | Database name                                                                                | `OutagesManagement`      |
| `database.username`     | Database username                                                                            | `OutagesManagementUser`  |
| `database.password`     | Database password                                                                            | `EO5r7MlfIA8UdegH`       |

### Application parameters

| Name              | Description                                                                                  | Value                           |
| ----------------- | -------------------------------------------------------------------------------------------- | ------------------------------- |
| `app.name`        | Application name                                                                             | `"Cluster Octopus"`             |
| `app.env`         | Application environment                                                                      | `"production"`                  |
| `app.debug`       | Application debug mode                                                                       | `"false"`                       |
| `app.locale`      | Application locale                                                                           | `"en"`                          |
| `app.timezone`    | Application timezone                                                                         | `"UTC"`                         |
| `app.key`         | Application encryption key                                                                   | `"base64:nFTljIbPWjsl/s2KPtIuztxaZ9mlXcphWgOt5M2LNtQ="` |

### RBAC parameters

| Name                           | Description                                                                                  | Value   |
| ------------------------------ | -------------------------------------------------------------------------------------------- | ------- |
| `rbac.create`                  | Enable RBAC                                                                                  | `true`  |
| `rbac.clusterRole.create`      | Enable ClusterRole creation                                                                  | `true`  |
| `rbac.clusterRole.name`        | The name of the ClusterRole to use                                                           | `""`    |
| `rbac.clusterRoleBinding.create` | Enable ClusterRoleBinding creation                                                          | `true`  |
| `rbac.clusterRoleBinding.name` | The name of the ClusterRoleBinding to use                                                   | `""`    |

### Other parameters

| Name                    | Description                                                                                  | Value   |
| ----------------------- | -------------------------------------------------------------------------------------------- | ------- |
| `nodeSelector`          | Node labels for pod assignment                                                               | `{}`    |
| `tolerations`           | Tolerations for pod assignment                                                               | `[]`    |
| `affinity`              | Affinity for pod assignment                                                                  | `{}`    |
| `extraEnvVars`          | Array with extra environment variables to add to Cluster Octopus containers                 | `[]`    |
| `extraVolumeMounts`     | Array with extra volume mounts to add to Cluster Octopus containers                         | `[]`    |
| `extraVolumes`          | Array with extra volumes to add to the Cluster Octopus deployment                           | `[]`    |

## Configuration and installation details

### Ingress

This chart provides support for Ingress resources. If you have an available Ingress Controller such as NGINX Ingress Controller, you can utilize the ingress configuration to expose your Cluster Octopus service.

To enable Ingress, set `ingress.enabled` to `true` and configure the `ingress.hosts` parameter.

### TLS Secrets

This chart will facilitate the creation of TLS secrets for use with the Ingress controller, however, this is not automated and will need to be configured manually.

### Persistence

The Cluster Octopus image stores the Cluster Octopus data and configurations at the `/nfsdata/data` path of the container.

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, and minikube.

## Troubleshooting

### Find more information

- [Cluster Octopus GitHub Repository](https://github.com/cgtysylr/cluster-octopus.git)

## License

Copyright &copy; 2025 cgtysylr.

Licensed under the [MIT License](https://github.com/cgtysylr/cluster-octopus/blob/main/LICENSE).
