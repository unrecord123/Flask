Flask Documentation

Flask is an open-source compatibility layer for macOS designed to run Windows executables (.exe and .msi) within isolated environments called "Bottles." It provides a graphical interface to manage Wine prefixes, making it easier to run Windows software without the overhead of a full virtual machine.

Core Concepts

The "Bottle" Architecture

In Flask, a "Bottle" is a specialized folder (technically a Wine Prefix) that acts as a self-contained Windows environment. Each Bottle has its own virtual C: drive, registry, and system files.

By isolating applications into different Bottles:

Stability: If one application requires specific settings or crashes, it won't affect other apps.

Organization: You can keep games, productivity tools, and utility software in separate environments.

Portability: Bottles are stored in ~/FlaskBottles, making them easy to back up.

The Translation Engine

Flask utilizes Wine (Wine Is Not an Emulator). Instead of simulating Windows hardware, it translates Windows API calls into macOS-native POSIX calls in real-time. This allows software to run at near-native speeds.

Installation and Setup

Prerequisites

To function, Flask requires the Wine engine. If you do not have it, you can install it via Homebrew:

brew install --cask wine-stable


Getting Started

Download: Obtain the Flask.app from the latest release.

Setup: Move the app to your /Applications folder.

Initialization: On first launch, right-click the app and select Open to confirm security permissions.

Using Flask

1. Creating a Bottle

Open Flask and click Create New Bottle. Give it a descriptive name (e.g., "Steam" or "LegacyOffice"). Flask will then initialize the Windows folder structure in the background.

2. Running an EXE

Select your desired Bottle from the list and click Run EXE in Bottle. A file picker will appear—locate your .exe or .msi file. Flask will execute the file within the environment variables of that specific Bottle.

Troubleshooting

Missing Wine: If Flask reports that Wine is missing, ensure your Homebrew path is correctly configured in your system environment.

App Not Opening: Because the app is not notarized, you must use the "Right-click > Open" method for the initial launch to tell macOS the software is trusted.

Flask is a community project built for education and accessibility. Contributions are welcome via Pull Requests.
