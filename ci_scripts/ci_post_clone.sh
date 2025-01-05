#!/bin/sh
curl https://mise.run | MISE_INSTALL_EXT=tar.gz sh

export PATH="$HOME/.local/bin:$PATH" # Installs the tools in .mise.toml in the project root

~/.local/bin/mise --version
~/.local/bin/mise install # Installs the version from .mise.toml

if [ "$CI" ]; then
     echo "Skip shims due to CI"
else
     echo "Activating shims for local dev"
     eval "$(mise activate bash --shims)" # activate shims to enable local use of mise
fi

mise doctor # verify the output of mise is correct on CI
echo "ABOUT TO GO FORWARD"

cd ..
~/.local/bin/mise x -- tuist fetch
echo "DID A FETCH"
~/.local/bin/mise x -- tuist install # Generate the Xcode Project using Tuist
~/.local/bin/mise x -- tuist generate # Generate the Xcode Project using Tuist
echo "DID A GENERATE"

exit 0
