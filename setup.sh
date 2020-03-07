#!/bin/sh
set -e

REPO_PATH=steviec/package-libvips-darwin
HOMEBREW_NO_AUTO_UPDATE=1
HOMEBREW_NO_INSTALL_CLEANUP=1

brew tap $REPO_PATH https://github.com/$REPO_PATH.git
KEEP_DEPENDENCIES=$(brew deps --include-build $REPO_PATH/vips)

echo "$KEEP_DEPENDENCIES"

brew update
brew cleanup
brew list -1 | grep -Ev ${KEEP_DEPENDENCIES// /|} | xargs brew uninstall --ignore-dependencies
brew uninstall --ignore-dependencies libtiff gdk-pixbuf
brew upgrade

brew install advancecomp
brew install $REPO_PATH/libtiff --build-bottle
brew install $REPO_PATH/gdk-pixbuf --build-bottle
brew postinstall $REPO_PATH/gdk-pixbuf
brew install $REPO_PATH/vips --build-bottle
