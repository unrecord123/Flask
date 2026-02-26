Flask Documentation

Flask is an open-source compatibility layer for macOS designed to run Windows executables (.exe and .msi) with zero configuration. It eliminates the technical hurdles of manual Wine management by automating the installation and wrapping process into a single-step graphical interface.

Core Concepts

The "Bottle" Architecture

In Flask, a "Bottle" is a specialized, self-contained Windows environment created automatically for your application. Each Bottle contains its own virtual filesystem, registry, and system settings.

By isolating applications:

Stability: Applications run in their own space, ensuring that specific configurations for one app do not interfere with others.

Simplicity: The complexity of the Windows file structure is hidden, allowing you to focus on your software.

Portability: Bottles are stored in ~/FlaskBottles, making them easy to manage or back up.

The Translation Engine

Flask utilizes Wine (Wine Is Not an Emulator). Instead of simulating Windows hardware, it translates Windows API calls into macOS-native calls in real-time. This allows software to run at near-native speeds without the massive battery and CPU drain of a Virtual Machine.

Installation and Setup

Prerequisites

Flask is designed to be self-sufficient. While it requires the Wine engine to function, you do not need to install it manually. If the engine is missing, Flask will automatically detect this on the first launch and offer to install it for you via Homebrew.

Getting Started

Download: Obtain the Flask.app from the latest release.

Setup: Move the app to your /Applications folder.

Initialization: On the first launch, right-click the app and select Open.

Using Flask

Flask is designed for a "one-click" experience. The workflow is entirely automated:

Launch & Auto-Setup: Upon opening Flask, the app will automatically check for the Wine engine. If it isn't found, Flask will handle the installation and update process for you.

Select Executable: Once the engine is ready, a Finder window will automatically appear. Simply navigate to and select your .exe or .msi file.

Automatic Wrapping: Flask will immediately build the Bottle, wrap the executable into a native macOS .app bundle, and place it on your Desktop.

Once the process is complete, you can close Flask and run your new Mac app whenever you like.

Troubleshooting

Permissions: Because the app is not notarized, you must use the "Right-click > Open" method for the initial launch so macOS knows you trust the software.

Installation Hangs: If the automatic Wine installation seems stuck, ensure you have an active internet connection, as it needs to download the engine components.

Flask is a community project built for education and accessibility. Contributions are welcome via Pull Requests.
