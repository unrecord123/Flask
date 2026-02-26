import AppKit
import Foundation

// Flask Wrapper Core
// Handles EXE selection and automatic .app bundling
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let panel = NSOpenPanel()
        panel.title = "Select Windows Application"
        panel.allowedFileTypes = ["exe", "msi"]
        if panel.runModal() == .OK, let exeUrl = panel.url { wrapFile(at: exeUrl) }
        NSApp.terminate(nil)
    }

    func wrapFile(at exeUrl: URL) {
        let fm = FileManager.default
        let desktop = fm.urls(for: .desktopDirectory, in: .userDomainMask).first!
        let appName = exeUrl.deletingPathExtension().lastPathComponent
        let appPath = desktop.appendingPathComponent("\(appName).app")
        let binPath = appPath.appendingPathComponent("Contents/MacOS")
        
        do {
            try fm.createDirectory(at: binPath, withIntermediateDirectories: true)
            let launchScript = """
            #!/bin/bash
            WINE=$(which wine || which /opt/homebrew/bin/wine || which /usr/local/bin/wine)
            if [ -z "$WINE" ]; then
                osascript -e 'display dialog "Flask Engine Missing. Install now?" buttons {"Install"}'
                brew install --cask wine-stable
                WINE=$(which wine || which /opt/homebrew/bin/wine || which /usr/local/bin/wine)
            fi
            PREFIX="$HOME/Library/Application Support/Flask/Bottles/\(appName)"
            mkdir -p "$PREFIX"
            WINEPREFIX="$PREFIX" WINEDEBUG=-all "$WINE" "\(exeUrl.path)" &
            """
            try launchScript.write(to: binPath.appendingPathComponent(appName), atomically: true, encoding: .utf8)
            try fm.setAttributes([.posixPermissions: 0o755], ofItemAtPath: binPath.appendingPathComponent(appName).path)
            
            let plist = """
            <?xml version="1.0" encoding="UTF-8"?>
            <plist version="1.0"><dict>
                <key>CFBundleExecutable</key><string>\(appName)</string>
                <key>CFBundleIdentifier</key><string>com.flask.auto.\(UUID().uuidString.prefix(6))</string>
                <key>CFBundleName</key><string>\(appName)</string>
                <key>CFBundlePackageType</key><string>APPL</string>
            </dict></plist>
            """
            try plist.write(to: appPath.appendingPathComponent("Contents/Info.plist"), atomically: true, encoding: .utf8)
        } catch { print(error) }
    }
}
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
