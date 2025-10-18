# Contributing to CSV Data Viewer

Thank you for your interest in contributing to CSV Data Viewer! This document provides guidelines and instructions for contributing.

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive experience for everyone. We expect all contributors to:
- Be respectful and considerate
- Accept constructive criticism gracefully
- Focus on what's best for the project and community
- Show empathy towards other community members

## How to Contribute

### Reporting Bugs

Before creating a bug report:
1. Check if the bug has already been reported in Issues
2. Make sure you're using the latest version
3. Test on a clean macOS installation if possible

When filing a bug report, include:
- **Clear title**: Describe the issue concisely
- **Environment**: macOS version, Xcode version, Swift version
- **Steps to reproduce**: Detailed steps to recreate the issue
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Screenshots**: If applicable
- **Sample CSV**: If the issue is data-related

### Suggesting Features

We welcome feature suggestions! Please:
1. Check if the feature has been requested already
2. Explain the use case clearly
3. Describe how it fits with existing features
4. Consider implementation complexity

### Pull Requests

#### Before Starting

1. **Discuss first**: For major changes, open an issue first
2. **Check roadmap**: Ensure it aligns with project direction
3. **One feature per PR**: Keep changes focused

#### Development Process

1. **Fork the repository**
   ```bash
   git clone https://github.com/tomaszpagacz/macOS-sandbox.git
   cd macOS-sandbox
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the coding style (see below)
   - Add tests for new functionality
   - Update documentation as needed

4. **Test thoroughly**
   ```bash
   swift test
   ```

5. **Commit your changes**
   ```bash
   git commit -m "Add feature: description"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create Pull Request**
   - Describe changes clearly
   - Reference related issues
   - Add screenshots for UI changes

#### PR Guidelines

- **Title**: Clear, concise description of changes
- **Description**: 
  - What changed and why
  - How to test
  - Screenshots (for UI changes)
  - Breaking changes (if any)
- **Tests**: Include unit tests
- **Documentation**: Update relevant docs

## Coding Style

### Swift Style Guide

Follow [Apple's Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/).

#### Key Points

1. **Naming**
   ```swift
   // Good
   func calculateColumnStatistics(for columnName: String) -> ColumnStats?
   
   // Bad
   func calcStats(_ col: String) -> ColumnStats?
   ```

2. **Comments**
   ```swift
   // Use comments sparingly, prefer self-documenting code
   // Comments should explain WHY, not WHAT
   
   // Good
   // Use linear search since array is typically small (<20 items)
   let index = columns.firstIndex { $0.name == columnName }
   
   // Bad
   // Loop through columns
   let index = columns.firstIndex { $0.name == columnName }
   ```

3. **SwiftUI Views**
   ```swift
   // Keep views small and focused
   // Extract complex UI into separate components
   
   // Good
   var body: some View {
       VStack {
           headerView
           contentView
           footerView
       }
   }
   
   // Bad
   var body: some View {
       VStack {
           // 100+ lines of UI code
       }
   }
   ```

4. **Error Handling**
   ```swift
   // Handle errors appropriately
   do {
       let content = try String(contentsOf: url)
       // Process content
   } catch {
       print("Error reading file: \(error.localizedDescription)")
       // Show user-friendly error message
   }
   ```

### File Organization

```
Sources/CSVDataViewer/
├── App/
│   └── CSVDataViewer.swift       # App entry point
├── Views/
│   ├── ContentView.swift          # Main view
│   ├── TableViewTab.swift         # Table view
│   └── ChartsViewTab.swift        # Charts view
├── ViewModels/
│   └── CSVDataViewModel.swift     # Business logic
├── Models/
│   └── (Data models)
└── Utilities/
    └── (Helper functions)
```

### Glassmorphism Design

Maintain design consistency:

```swift
// Use these patterns for glassmorphism effects
.background(
    RoundedRectangle(cornerRadius: 16)
        .fill(.ultraThinMaterial)
        .opacity(0.2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white.opacity(0.2), lineWidth: 1)
        )
)
```

## Testing

### Writing Tests

1. **Unit Tests**: Test business logic
   ```swift
   func testColumnStatistics() {
       // Arrange
       let viewModel = CSVDataViewModel()
       // ... setup
       
       // Act
       let stats = viewModel.getColumnStats(for: "Age")
       
       // Assert
       XCTAssertEqual(stats?.mean, 30.0)
   }
   ```

2. **UI Tests**: Test user interactions (when available)

3. **Manual Testing**: Always test manually on macOS

### Testing Checklist

- [ ] Unit tests pass
- [ ] No compiler warnings
- [ ] App builds successfully
- [ ] Feature works as expected
- [ ] No regression in existing features
- [ ] UI looks correct on different screen sizes
- [ ] Performance is acceptable with large CSV files

## Documentation

### Code Documentation

Use Swift documentation comments:

```swift
/// Calculates statistical summary for a numeric column
/// 
/// - Parameter columnName: The name of the column to analyze
/// - Returns: Column statistics or nil if column is not numeric
func getColumnStats(for columnName: String) -> ColumnStats? {
    // Implementation
}
```

### User Documentation

Update these files when relevant:
- `README.md`: Overview and quick start
- `USER_GUIDE.md`: Detailed usage instructions
- `DESIGN.md`: Design system documentation
- `BUILD.md`: Build and development instructions

## Performance Guidelines

1. **Efficient Algorithms**
   - O(n) for filtering and sorting is acceptable
   - Avoid nested loops when possible
   - Use lazy evaluation where appropriate

2. **Memory Management**
   - Don't load entire file into memory unnecessarily
   - Use weak references to avoid retain cycles
   - Release resources when done

3. **UI Performance**
   - Keep view updates on main thread
   - Use lazy loading for lists
   - Optimize redraw regions

## Accessibility

Ensure your changes are accessible:
- Provide alternative text for images
- Support keyboard navigation
- Use semantic labels
- Test with VoiceOver
- Ensure sufficient color contrast

## Release Process

(For maintainers)

1. Update version in `Info.plist`
2. Update `CHANGELOG.md`
3. Create release tag
4. Build release binary
5. Create GitHub release
6. Update documentation

## Getting Help

- **Questions**: Open a GitHub Discussion
- **Chat**: (If available) Join our Discord/Slack
- **Issues**: For bugs and feature requests

## Recognition

Contributors will be:
- Listed in release notes
- Mentioned in README
- Credited in app (for significant contributions)

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to CSV Data Viewer! 🎉
