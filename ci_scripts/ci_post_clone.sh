#!/bin/sh

# Install Tuist
curl -Ls https://install.tuist.io | bash

# Make sure Tuist is available in PATH
export PATH="$HOME/.tuist/bin:$PATH"

# Verify Tuist installation
tuist --version

# Clean up and generate Xcode project with Tuist
tuist clean
tuist generate --no-open
