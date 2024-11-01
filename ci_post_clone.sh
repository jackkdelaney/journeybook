#!/bin/sh
curl https://mise.jdx.dev/install.sh | sh
mise install # Installs the version from .mise.toml

# Runs the version of Tuist indicated in the .mise.toml file {#runs-the-version-of-tuist-indicated-in-the-misetoml-file}
mise x tuist generate

if [ ! -d "JourneyBook.xcworkspacee" ]; then
    echo "Error: JourneyBook.xcworkspacee was not generated."
    exit 1
fi