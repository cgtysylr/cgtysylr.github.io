# Cluster Octopus Helm Charts

This repository contains Helm charts for [Cluster Octopus](https://github.com/cgtysylr/cluster-octopus.git), a Kubernetes cluster monitoring and management solution.

## 📦 Available Charts

| Chart | Description | Version |
|-------|-------------|---------|
| [cluster-octopus](./cluster-octopus) | Cluster Octopus DaemonSet for Kubernetes monitoring | [1.0.0](./cluster-octopus) |

## 🚀 Quick Start

### Add the Helm Repository

```bash
helm repo add cluster-octopus https://cgtysylr.github.io/co-artifacthub/
helm repo update
```

### Install Cluster Octopus

```bash
helm install my-cluster-octopus cluster-octopus/cluster-octopus
```

### Upgrade Cluster Octopus

```bash
helm upgrade my-cluster-octopus cluster-octopus/cluster-octopus
```

### Uninstall Cluster Octopus

```bash
helm uninstall my-cluster-octopus
```

## 📋 Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure

## 🔧 Configuration

See the [cluster-octopus chart documentation](./cluster-octopus/README.md) for detailed configuration options.

## 🛠️ Development

### Repository Structure

```
co-artifacthub/
├── docs/                    # GitHub Pages (public)
│   ├── index.yaml          # Helm repository index
│   └── charts/             # Chart packages
├── cluster-octopus/        # Chart source code
├── scripts/                # Automation scripts
│   └── update-repo.sh      # Repository update script
└── README.md               # This file
```

### Adding a New Chart Version

1. Update the chart version in `cluster-octopus/Chart.yaml`
2. Run the update script:
   ```bash
   ./scripts/update-repo.sh
   ```
3. Commit and push changes to GitHub

### Local Development

```bash
# Clone the repository
git clone https://github.com/cgtysylr/co-artifacthub.git
cd co-artifacthub

# Install dependencies (if any)
# ...

# Run the update script
./scripts/update-repo.sh

# Test the chart locally
helm install test-release ./cluster-octopus --dry-run
```

## 📚 Documentation

- [Cluster Octopus GitHub Repository](https://github.com/cgtysylr/cluster-octopus.git)
- [Cluster Octopus Chart Documentation](./cluster-octopus/README.md)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test your changes
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- [Cluster Octopus GitHub Repository](https://github.com/cgtysylr/cluster-octopus.git)
- [Helm Documentation](https://helm.sh/docs/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
