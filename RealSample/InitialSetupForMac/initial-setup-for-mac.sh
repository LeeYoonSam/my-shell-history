#!/bin/bash

# Install Xcode command line tool (if not already installed)
xcode-select --install

# Check if Homebrew is installed, and install it if it's not
if ! [ -x "$(command -v brew)" ]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
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

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "zsh installation completed successfully."

    # Perform action after installation
    echo "Performing post-installation action..."

    # Set theme for Oh My Zsh
    sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc

    echo "Post-installation action completed."
else
    echo "Oh My Zsh installation failed. Please check the installation logs for more details."
fi

# Install PowerLine Font
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts


# Install Android SDK
brew install android-sdk

if [ $? -eq 0 ]; then
    # Set environment variable for Android SDK
    echo 'export ANDROID_HOME=/usr/local/share/android-sdk' >> ~/.zshrc
    echo 'export PATH=$PATH:$ANDROID_HOME/bin' >> ~/.zshrc
else
    echo "android-sdk installation failed. Please check the installation logs for more details."
fi

# Install ADB
brew install --cask android-platform-tools

function getBashAliases() {
    # get Default alias
    git clone https://github.com/LeeYoonSam/my-shell-history --depth=1
    cd my-shell-history/RealSample/alias/usecase
    cp .bash_aliases ~/.bash_aliases
    cd ../../../../
    rm -rf my-shell-history
    source ~/.bash_aliases
}

getBashAliases

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