# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-10-18

### Added
- Initial release of CSV Data Viewer
- CSV file import with native macOS file picker
- Interactive data table with scrolling
- Column-based filtering with real-time search
- Click-to-sort functionality for all columns
- Automatic detection of numeric columns
- Advanced analytics tab with charts
- Multiple chart types: Bar, Line, and Area charts
- Statistical summaries: Min, Mean, Max for numeric columns
- Glassmorphism design system throughout
- Bloomberg Terminal-inspired dark theme
- Beautiful gradient backgrounds and effects
- Frosted glass UI components
- Responsive layout for various window sizes
- Sample CSV data for testing
- Comprehensive documentation:
  - README.md with feature overview
  - USER_GUIDE.md with detailed usage instructions
  - DESIGN.md with design system documentation
  - BUILD.md with build instructions
  - CONTRIBUTING.md with contribution guidelines
- Unit tests for core functionality
- MIT License

### Design Features
- Dark theme optimized for data focus
- Cyan and blue accent colors
- Monospaced fonts for data display
- Rounded fonts for UI elements
- Smooth animations and transitions
- Native macOS UI patterns
- Professional typography hierarchy

### Technical Details
- Built with Swift 6.2
- SwiftUI for UI framework
- Swift Charts for data visualization
- Supports macOS 14.0 (Sonoma) and later
- Swift Package Manager for dependency management
- MVVM architecture pattern
- ObservableObject for state management

## [Unreleased]

### Planned
- Export filtered data to CSV
- Save/Load filter configurations
- Custom color themes
- Light mode support
- Additional chart types (Scatter, Pie, Donut)
- Data aggregation functions (SUM, AVG, COUNT)
- Multiple file comparison
- Excel file support (.xlsx)
- Cloud storage integration (iCloud, Dropbox)
- Keyboard shortcuts customization
- Column width adjustment
- Drag-and-drop file import
- Recent files menu
- Preferences window
- Print/PDF export
- Search across all columns
- Advanced filtering (ranges, regex)
- Column hiding/reordering
- Data validation
- Error highlighting

---

## Release Notes

### Version 1.0.0 - Initial Release

This is the first public release of CSV Data Viewer, a professional-grade macOS application for visualizing CSV data with a beautiful glassmorphism design.

**What's New:**
- Complete CSV viewing and analysis solution
- Stunning visual design inspired by Bloomberg Terminal
- Interactive filtering and sorting
- Automatic chart generation for numeric data
- Three chart types with instant switching
- Real-time data filtering
- Professional dark theme

**System Requirements:**
- macOS 14.0 or later
- 64-bit processor
- 100 MB disk space

**Known Issues:**
- None in this release

**Feedback:**
Please report any issues or feature requests on our GitHub repository.

---

[1.0.0]: https://github.com/tomaszpagacz/macOS-sandbox/releases/tag/v1.0.0
