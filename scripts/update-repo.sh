#!/bin/bash

# Cluster Octopus Helm Repository Update Script
# This script updates the Helm repository index and packages charts

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

echo -e "${GREEN}🚀 Cluster Octopus Helm Repository Update Script${NC}"
echo "=================================================="

# Check if helm is installed
if ! command -v helm &> /dev/null; then
    echo -e "${RED}❌ Helm is not installed. Please install Helm first.${NC}"
    exit 1
fi

# Function to package chart
package_chart() {
    local chart_name=$1
    local chart_dir="$REPO_ROOT/$chart_name"
    
    if [ ! -d "$chart_dir" ]; then
        echo -e "${YELLOW}⚠️  Chart directory $chart_dir not found, skipping...${NC}"
        return
    fi
    
    echo -e "${GREEN}📦 Packaging $chart_name chart...${NC}"
    cd "$chart_dir"
    
    # Lint the chart
    echo -e "${YELLOW}🔍 Linting $chart_name chart...${NC}"
    if helm lint .; then
        echo -e "${GREEN}✅ Chart linting passed${NC}"
    else
        echo -e "${RED}❌ Chart linting failed${NC}"
        exit 1
    fi
    
    # Package the chart
    echo -e "${YELLOW}📦 Packaging $chart_name chart...${NC}"
    helm package .
    
    # Move the package to docs/charts
    local package_file=$(ls -t *.tgz | head -1)
    if [ -n "$package_file" ]; then
        mv "$package_file" "$REPO_ROOT/docs/charts/"
        echo -e "${GREEN}✅ Moved $package_file to docs/charts/${NC}"
    fi
}

# Function to update repository index
update_index() {
    echo -e "${GREEN}📋 Updating repository index...${NC}"
    cd "$REPO_ROOT/docs"
    helm repo index .
    echo -e "${GREEN}✅ Repository index updated${NC}"
}

# Function to validate repository
validate_repository() {
    echo -e "${GREEN}🔍 Validating repository...${NC}"
    cd "$REPO_ROOT/docs"
    
    # Check if index.yaml exists
    if [ ! -f "index.yaml" ]; then
        echo -e "${RED}❌ index.yaml not found${NC}"
        exit 1
    fi
    
    # Check if charts directory exists
    if [ ! -d "charts" ]; then
        echo -e "${RED}❌ charts directory not found${NC}"
        exit 1
    fi
    
    # Check if charts exist
    local chart_count=$(ls charts/*.tgz 2>/dev/null | wc -l)
    if [ "$chart_count" -eq 0 ]; then
        echo -e "${RED}❌ No chart packages found in charts/ directory${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Repository validation passed${NC}"
    echo -e "${GREEN}📊 Found $chart_count chart package(s)${NC}"
}

# Main execution
main() {
    echo -e "${YELLOW}📁 Repository root: $REPO_ROOT${NC}"
    
    # Create docs directory if it doesn't exist
    if [ ! -d "$REPO_ROOT/docs" ]; then
        echo -e "${YELLOW}📁 Creating docs directory...${NC}"
        mkdir -p "$REPO_ROOT/docs/charts"
    fi
    
    # Package all charts
    echo -e "${GREEN}📦 Packaging charts...${NC}"
    package_chart "cluster-octopus"
    
    # Update repository index
    update_index
    
    # Validate repository
    validate_repository
    
    echo -e "${GREEN}🎉 Repository update completed successfully!${NC}"
    echo ""
    echo -e "${YELLOW}📋 Next steps:${NC}"
    echo "1. Commit and push changes to GitHub"
    echo "2. Ensure GitHub Pages is enabled for the docs/ directory"
    echo "3. Your Helm repository will be available at:"
    echo "   https://cgtysylr.github.io/co-artifacthub/"
    echo ""
    echo -e "${YELLOW}🔗 To add this repository:${NC}"
    echo "   helm repo add cluster-octopus https://cgtysylr.github.io/co-artifacthub/"
    echo "   helm repo update"
    echo ""
    echo -e "${YELLOW}📦 To install the chart:${NC}"
    echo "   helm install my-release cluster-octopus/cluster-octopus"
}

# Run main function
main "$@"
