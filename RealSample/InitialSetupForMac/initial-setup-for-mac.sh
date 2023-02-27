#!/bin/bash

# Install Xcode command line tool (if not already installed)
xcode-select --install

# Check if Homebrew is installed, and install it if it's not
if test ! $(which brew); then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL <https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh>)"
fi

# Update Homebrew and any existing formulae
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install Git
brew install git

# Install Node.js
brew install node

# Install Visual Studio Code
brew install --cask visual-studio-code

# Install Jetbrains Toolbox
brew install --cask jetbrains-toolbox

# Install zsh
brew install zsh

# Install Oh My Zsh
sh -c "$(curl -fsSL <https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh>)"

# Set theme for Oh My Zsh
sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc

# Install Android SDK
brew install android-sdk

# Set environment variable for Android SDK
echo 'export ANDROID_HOME=/usr/local/share/android-sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/bin' >> ~/.zshrc

# Install Figma
brew install --cask figma

# Install Charles
brew install --cask charles

# Install Postman
brew install --cask postman

# Install Notion
brew install --cask notion

# Install Slack
brew install --cask slack

# Install Chrome
brew install --cask google-chrome