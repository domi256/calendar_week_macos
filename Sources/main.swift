import Cocoa

private let prefKey = "showKWPrefix"

class StatusBarController: NSObject {
    private var statusItem: NSStatusItem
    private var showPrefix: Bool
    private var timer: Timer?

    override init() {
        showPrefix = UserDefaults.standard.object(forKey: prefKey) as? Bool ?? true
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        super.init()
        updateMenu()
        updateDisplay()
        startTimer()
    }

    private func currentWeek() -> Int {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone.current
        return calendar.component(.weekOfYear, from: Date())
    }

    func updateDisplay() {
        let week = currentWeek()
        let title = showPrefix ? "KW\(week)" : "\(week)"
        DispatchQueue.main.async {
            self.statusItem.button?.title = title
        }
    }

    private func updateMenu() {
        let menu = NSMenu()

        let toggleItem = NSMenuItem(
            title: "Show \"KW\" prefix",
            action: #selector(togglePrefix(_:)),
            keyEquivalent: ""
        )
        toggleItem.target = self
        toggleItem.state = showPrefix ? .on : .off
        menu.addItem(toggleItem)

        menu.addItem(.separator())

        let quitItem = NSMenuItem(
            title: "Quit Calendar Week",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        )
        menu.addItem(quitItem)

        statusItem.menu = menu
    }

    @objc private func togglePrefix(_ sender: NSMenuItem) {
        showPrefix = !showPrefix
        UserDefaults.standard.set(showPrefix, forKey: prefKey)
        updateMenu()
        updateDisplay()
    }

    private func startTimer() {
        // Check every 60 s so we catch the Monday midnight week rollover
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.updateDisplay()
        }
        RunLoop.main.add(timer!, forMode: .common)
    }
}

// ── Entry point ─────────────────────────────────────────────────────────────

let app = NSApplication.shared
app.setActivationPolicy(.accessory) // hide from Dock

class AppDelegate: NSObject, NSApplicationDelegate {
    var controller: StatusBarController!

    func applicationDidFinishLaunching(_ notification: Notification) {
        controller = StatusBarController()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        false
    }
}

let delegate = AppDelegate()
app.delegate = delegate
app.run()
