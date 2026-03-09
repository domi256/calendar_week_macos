# Calendar Week — macOS Menu Bar App

A minimal macOS menu bar app that shows the current ISO calendar week number.

![Status bar showing KW10](https://placehold.co/200x40/1c1c1e/ffffff?text=KW10)

## Features

- Displays the current ISO 8601 calendar week (e.g. **KW10**)
- Toggle the `KW` prefix on/off via the menu — shows just the number (e.g. **10**)
- Preference persists across restarts
- Adapts automatically to **dark and light mode**
- Uses your **local timezone**
- No Dock icon — lives only in the menu bar
- Zero dependencies — pure Swift + AppKit

## Requirements

- macOS 12 or later
- Xcode Command Line Tools (`xcode-select --install`)

## Installation

```bash
# 1. Clone the repo
git clone https://github.com/your-username/calendar-week.git
cd calendar-week

# 2. Build
bash build.sh

# 3. Install
cp -r build/CalendarWeek.app ~/Applications/
open ~/Applications/CalendarWeek.app
```

The app appears in your menu bar immediately. No setup needed.

### Auto-start on login

Go to **System Settings → General → Login Items** and add `CalendarWeek.app`.

## Usage

| Action | Result |
|--------|--------|
| Click the menu bar item | Opens the menu |
| Toggle "Show 'KW' prefix" | Switch between `KW10` and `10` |
| Press Q / click "Quit" | Quits the app |

## Building from source

The entire app is a single Swift file compiled with `swiftc` — no Xcode project required.

```bash
bash build.sh
```

Output is placed in `build/CalendarWeek.app`.

## How it works

- Week numbers follow the **ISO 8601** standard (weeks start on Monday, week 1 contains the first Thursday of the year) — the same standard used in Germany, Austria, Switzerland, and most of Europe.
- The display refreshes every 60 seconds, so it automatically rolls over to the new week number at midnight on Monday.

## License

MIT
