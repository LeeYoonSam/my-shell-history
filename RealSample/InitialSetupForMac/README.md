# 맥 개발 초기 세팅하기

# Mac OS Developer Initial Setup

If you are a new Mac OS developer, you need to set up your system to get started with the software development process. This document outlines the essential steps to set up your Mac OS for software development.

## Install Xcode

Xcode is an Integrated Development Environment (IDE) for macOS. You can download and install Xcode from the App Store. Once installed, you can use Xcode to develop applications for macOS, iOS, watchOS, and tvOS.

## Install Homebrew

Homebrew is a package manager for macOS. It allows you to install and manage software packages easily. To install Homebrew, open your Terminal and run the following command:

```
/bin/bash -c "$(curl -fsSL <https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh>)"
```

## Install Git

Git is a version control system that is widely used in the software development process. To install Git, open your Terminal and run the following command:

```
brew install git
```

## Install Node.js

Node.js is an open-source, cross-platform JavaScript runtime environment. It allows you to run JavaScript on the server-side. To install Node.js, open your Terminal and run the following command:

```
brew install node
```

## Install Visual Studio Code and Jetbrains Toolbox

Visual Studio Code is a lightweight but powerful source code editor that runs on your desktop. To install Visual Studio Code, open your Terminal and run the following command:

```
brew install --cask visual-studio-code
```

Jetbrains Toolbox is an application that allows you to manage and install multiple Jetbrains IDEs, including IntelliJ IDEA, PyCharm, and more. To install Jetbrains Toolbox, open your Terminal and run the following command:

```
brew install --cask jetbrains-toolbox
```

Once you have completed these steps, your Mac OS is now set up for software development. Happy coding!

## Oh My Zsh 설치

To install zsh with a custom theme using Homebrew, follow the steps below:

1. Install zsh using Homebrew by running the following command in your Terminal:

```
brew install zsh
```

1. Install Oh My Zsh, a community-driven framework for managing your zsh configuration, by running the following command:

```
sh -c "$(curl -fsSL <https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh>)"
```

1. Once Oh My Zsh is installed, you can choose from a variety of themes. You can see the available themes by opening the `.zshrc` file in your home directory:

```
open ~/.zshrc
```

1. In the `.zshrc` file, look for the `ZSH_THEME` line and change the value to your desired theme. For example, if you want to use the "agnoster" theme, change the line to:

```
ZSH_THEME="agnoster"
```

1. Save and close the `.zshrc` file.
2. Restart your terminal to see the new theme in action.

## PowerLine Font 설치
```bash
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
```

## Mac OS Command Line Tool 설치

Mac OS Command Line Tool은 개발에 필요한 여러 유틸리티를 제공하는 패키지입니다. Command Line Tool을 설치하려면 다음 단계를 따르세요:

1. Terminal을 엽니다.
2. 다음 명령어를 입력하고 실행하세요:

```
xcode-select --install
```

1. Install 버튼을 클릭합니다.

---

# Android 관련

You can install the Android SDK using Homebrew on macOS by following these steps:

1. Open your Terminal and run the following command to update Homebrew:

```
brew update
```

1. Run the following command to install the Android SDK:

```
brew install android-sdk
```

1. After installation, you can find the Android SDK in the following directory:

```
/usr/local/share/android-sdk
```

1. You can set the `ANDROID_HOME` environment variable to the location of the Android SDK. To do this, run the following command:

```
export ANDROID_HOME=/usr/local/share/android-sdk
```

1. You can also add the `bin` directory of the Android SDK to your `PATH` environment variable. To do this, run the following command:

```
export PATH=$PATH:$ANDROID_HOME/bin
```

---

# 응용프로그램 설치

## Figma 설치하기

Figma는 macOS에서 실행되는 디자인 도구입니다. 다음 명령어를 실행하여 설치할 수 있습니다.

```
brew install --cask figma

```

## Charles 설치하기

Charles는 macOS에서 실행되는 웹 디버깅 프록시 도구입니다. 다음 명령어를 실행하여 설치할 수 있습니다.

```
brew install --cask charles

```

## Postman 설치하기

Postman은 macOS에서 실행되는 API 개발 도구입니다. 다음 명령어를 실행하여 설치할 수 있습니다.

```
brew install --cask postman

```

## Notion 설치하기

Notion은 macOS에서 실행되는 협업 도구입니다. 다음 명령어를 실행하여 설치할 수 있습니다.

```
brew install --cask notion

```

## Slack 설치하기

Slack은 macOS에서 실행되는 팀 커뮤니케이션 도구입니다. 다음 명령어를 실행하여 설치할 수 있습니다.

```
brew install --cask slack

```

## Chrome 설치하기

```
brew install --cask google-chrome

```

---

# 쉘 스크립트 샘플
[Shell Script](./initial-setup-for-mac.sh)

일부 작업을 수동으로 확인해야하기 때문에, 이 스크립트에는 그러한 작업을 자동화하는 코드는 포함되지 않습니다. 그러나 아래 스크립트는 Homebrew가 설치되어 있지 않은 경우 Homebrew를 자동으로 설치합니다.
따라서, 스크립트를 실행하기 전에 수동으로 확인해야 할 작업들이 있습니다. 이러한 작업에는 Apple ID 로그인, 기존 패키지 삭제 또는 업그레이드 등이 해당됩니다.

## 참고
- Notion 에서 제공하는 AI 기능을 이용해서 노션 문서 작성 및 쉘 스크립트를 생성했습니다.