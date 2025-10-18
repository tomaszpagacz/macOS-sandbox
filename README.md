# CSV Data Viewer for macOS

A beautiful, enterprise-grade CSV data visualization application for macOS with glassmorphism design, inspired by Bloomberg Terminal's focus and attention to detail.

![macOS CSV Data Viewer](https://img.shields.io/badge/platform-macOS-blue)
![Swift](https://img.shields.io/badge/Swift-6.2-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-Latest-green)

## Features

### 📊 Data Visualization
- **Interactive Table View**: Display CSV data in a clean, organized table
- **Column Filters**: Real-time filtering for all columns with search functionality
- **Smart Sorting**: Click column headers to sort data (numeric and alphabetic)
- **Automatic Type Detection**: Identifies numeric columns for enhanced functionality

### 📈 Advanced Analytics
- **Multiple Chart Types**: Bar, Line, and Area charts for all numeric columns
- **Statistical Summary**: Displays Min, Mean, and Max values for each metric
- **Distribution Analysis**: Histogram visualization with automatic binning
- **Interactive Charts**: Built with Swift Charts for smooth, native performance

### 🎨 Glassmorphism Design
- **Modern UI**: Frosted glass effects with transparency and blur
- **Bloomberg-Inspired**: Dark theme optimized for data focus and reduced eye strain
- **Smooth Animations**: Fluid transitions and interactions
- **Professional Typography**: Monospaced fonts for data, rounded fonts for UI

## Requirements

- macOS 14.0 (Sonoma) or later
- Xcode 15.0 or later
- Swift 6.2 or later

## Installation

### Building from Source

1. Clone the repository:
```bash
git clone https://github.com/tomaszpagacz/macOS-sandbox.git
cd macOS-sandbox
```

2. Build the project:
```bash
swift build
```

3. Run the application:
```bash
swift run
```

### Using Xcode

1. Open the project in Xcode:
```bash
xed .
```

2. Build and run (⌘R)

## Usage

### Importing CSV Files

1. Launch the application
2. Click "Import CSV" or drag and drop a CSV file
3. The app automatically parses headers and data
4. View your data in the Table tab

### Working with Data

**Table View**:
- Use filter boxes under each column header to search
- Click column headers to sort
- Numeric columns are marked with a number icon

**Analytics View**:
- Automatically shows charts for all numeric columns
- Switch between Bar, Line, and Area chart types
- View statistical summaries (Min, Mean, Max)

### Supported CSV Format

- Standard CSV format with comma delimiters
- First row must contain column headers
- Supports quoted fields with commas
- Automatic numeric type detection

Example:
```csv
Name,Age,Salary,Department
John Doe,35,75000,Engineering
Jane Smith,28,65000,Marketing
Bob Johnson,42,85000,Engineering
```

## Architecture

### Project Structure

```
CSVDataViewer/
├── CSVDataViewer.swift      # App entry point
├── ContentView.swift         # Main view with navigation
├── CSVDataViewModel.swift    # Data model and business logic
├── TableViewTab.swift        # Table display with filters
└── ChartsViewTab.swift       # Analytics and visualizations
```

### Design Patterns

- **MVVM Architecture**: Clear separation of concerns
- **ObservableObject**: Reactive state management with Combine
- **SwiftUI**: Declarative UI framework
- **Swift Charts**: Native charting framework

### Key Components

**CSVDataViewModel**:
- Handles CSV parsing and data management
- Implements filtering and sorting logic
- Provides statistics for numeric columns

**Glassmorphism Components**:
- Reusable background effects
- Consistent styling across views
- Material effects with transparency

## Customization

### Changing Color Scheme

Edit the gradient colors in `ContentView.swift`:

```swift
LinearGradient(
    colors: [
        Color(red: 0.02, green: 0.02, blue: 0.08),
        Color(red: 0.05, green: 0.05, blue: 0.15)
    ],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)
```

### Adjusting Window Size

Modify minimum dimensions in `CSVDataViewer.swift`:

```swift
.frame(minWidth: 1200, minHeight: 800)
```

### Chart Binning

Adjust histogram bins in `ChartsViewTab.swift`:

```swift
let binCount = min(20, stats.values.count) // Change 20 to desired bin count
```

## Technical Highlights

### CSV Parsing
- Handles quoted fields with embedded commas
- Robust error handling
- Memory-efficient streaming for large files

### Performance
- Lazy loading for large datasets
- Efficient filtering algorithms
- Native SwiftUI rendering

### Accessibility
- VoiceOver support through semantic labels
- Keyboard navigation
- Dynamic type support

## Future Enhancements

- [ ] Export filtered data to CSV
- [ ] Save/Load filter configurations
- [ ] Custom color themes
- [ ] Additional chart types (Scatter, Pie)
- [ ] Data aggregation functions
- [ ] Multiple file comparison
- [ ] Excel file support
- [ ] Cloud storage integration

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available for learning purposes.

## Acknowledgments

- Inspired by Bloomberg Terminal's data-focused interface
- Built with Apple's SwiftUI and Swift Charts frameworks
- Glassmorphism design principles

## Support

For issues or questions, please open an issue on GitHub.

---

**Built with ❤️ for macOS**

