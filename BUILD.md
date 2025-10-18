# Building and Running

## Prerequisites

This is a **macOS-only** application that requires:
- macOS 14.0 (Sonoma) or later
- Xcode 15.0 or later
- Swift 6.2 or later

## Why this doesn't build on Linux

This application uses macOS-specific frameworks:
- **AppKit**: For native file dialogs (`NSOpenPanel`)
- **SwiftUI**: macOS-specific UI components
- **Swift Charts**: Apple's native charting framework

These frameworks are not available on Linux, so the build will fail in a Linux environment.

## Building on macOS

### Option 1: Using Xcode (Recommended)

1. Open Terminal and navigate to the project directory
2. Open in Xcode:
   ```bash
   xed .
   ```
3. Wait for package resolution
4. Select "My Mac" as the target
5. Press ⌘R to build and run

### Option 2: Using Swift Package Manager

From the project directory:
```bash
swift build -c release
```

To run:
```bash
swift run
```

## Development Setup

1. Clone the repository on a Mac:
   ```bash
   git clone https://github.com/tomaszpagacz/macOS-sandbox.git
   cd macOS-sandbox
   ```

2. Open in Xcode:
   ```bash
   xed .
   ```

3. Xcode will automatically:
   - Resolve package dependencies
   - Set up build configurations
   - Configure code signing (if needed)

## Running Tests

In Xcode:
```
⌘U (or Product > Test)
```

Using Swift Package Manager:
```bash
swift test
```

## Creating a Release Build

1. In Xcode, select Product > Archive
2. Follow the distribution workflow
3. Or use command line:
   ```bash
   swift build -c release
   ```

The executable will be in:
```
.build/release/CSVDataViewer
```

## Troubleshooting

### "Cannot find 'AppKit' in scope"
- This is expected on non-macOS systems
- Must be built on macOS

### Code signing issues
- Go to Signing & Capabilities in Xcode
- Select your development team
- Or disable code signing for development

### Window doesn't appear
- Check macOS accessibility permissions
- Ensure app is not hidden in Dock

## Next Steps

After building, see the main [README.md](README.md) for usage instructions.
