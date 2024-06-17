# Custom Chrome Launcher

This repository provides a script to launch Google Chrome with a temporary user data directory 
and various configurations to minimize browser fingerprinting. The script randomly modifies the 
user agent to enhance privacy while maintaining compatibility with different Chrome versions.

## Features

- Launches Google Chrome with a temporary user data directory.
- Deletes the temporary directory upon closing Chrome.
- Randomly modifies the user agent to reduce browser fingerprinting.
- Configurable options to disable various features that contribute to fingerprinting.
- Ensures the browser runs in incognito mode by default.

## Requirements

- Google Chrome installed on your system.
- A Unix-like operating system (Linux). (Pull-requests accepted to other OS)

## Installation

1. Clone this repository to your local machine:
   ```sh
   git clone https://github.com/yourusername/custom-chrome-launcher.git
   cd custom-chrome-launcher

## Usage

```shell
./launch_chrome.sh
```
