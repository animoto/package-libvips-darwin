#!/bin/sh
set -e

REPO_LOCATION=steviec/package-libvips-darwin
HOMEBREW_NO_AUTO_UPDATE=1
HOMEBREW_NO_INSTALL_CLEANUP=1

brew tap $REPO_LOCATION https://github.com/$REPO_LOCATION.git
KEEP_DEPENDENCIES=$(brew deps --include-build $REPO_LOCATION/vips)

echo "$KEEP_DEPENDENCIES"

brew update
brew cleanup
brew list -1 | grep -Ev ${KEEP_DEPENDENCIES// /|} | xargs brew uninstall --force --ignore-dependencies
brew uninstall --force --ignore-dependencies libtiff gdk-pixbuf
brew upgrade

brew install advancecomp
brew install $REPO_LOCATION/libtiff --build-bottle
brew install $REPO_LOCATION/gdk-pixbuf --build-bottle
brew postinstall $REPO_LOCATION/gdk-pixbuf
brew install $REPO_LOCATION/vips --build-bottle
