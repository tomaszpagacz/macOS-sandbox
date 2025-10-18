# Visual Design Guide

## Design Philosophy

The CSV Data Viewer combines the professional aesthetic of Bloomberg Terminal with modern macOS glassmorphism design principles.

## Core Design Elements

### 1. Glassmorphism
- **Frosted glass effects** using `.ultraThinMaterial`
- **Semi-transparent overlays** with opacity adjustments
- **Subtle borders** with gradient strokes
- **Layered depth** through shadows and blur

### 2. Color Palette

#### Background
- Primary: `rgb(5, 5, 20)` - Deep navy/black
- Secondary: `rgb(13, 13, 38)` - Slightly lighter navy
- Creates a dark, professional environment for data focus

#### Accent Colors
- **Primary Accent**: Cyan (`#00D9FF`) - For highlights and important data
- **Secondary Accent**: Blue (`#0099FF`) - For interactive elements
- **Success**: Green - For positive metrics
- **Numeric Indicators**: Cyan with glow effect

#### Text
- Primary Text: White with 90% opacity
- Secondary Text: White with 60% opacity
- Monospaced Data: White with 90% opacity (SF Mono)
- Labels: White with 50% opacity

### 3. Typography

#### Font Families
- **UI Elements**: SF Pro Rounded (`.rounded`)
- **Data Display**: SF Mono (`.monospaced`)
- **Headings**: SF Pro Rounded Bold

#### Font Sizes
- **Large Title**: 28pt (Main headings)
- **Title**: 24pt (Section headers)
- **Headline**: 20pt (Card titles)
- **Body**: 16pt (Primary content)
- **Data**: 11-14pt (Table cells, metrics)
- **Caption**: 10-12pt (Labels, descriptions)

### 4. Spacing System

Following an 8-point grid:
- **XS**: 4pt
- **S**: 8pt
- **M**: 16pt
- **L**: 20pt
- **XL**: 24pt

### 5. Component Styles

#### Buttons
```swift
.padding(.horizontal, 16)
.padding(.vertical, 8)
.background(
    RoundedRectangle(cornerRadius: 10)
        .fill(LinearGradient(
            colors: [.blue.opacity(0.8), .cyan.opacity(0.6)]
        ))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
)
```

#### Cards
```swift
.background(
    RoundedRectangle(cornerRadius: 16)
        .fill(.ultraThinMaterial)
        .opacity(0.2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.3), radius: 20)
)
```

#### Input Fields
```swift
.background(
    RoundedRectangle(cornerRadius: 6)
        .fill(.ultraThinMaterial)
        .opacity(0.3)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(.white.opacity(0.2), lineWidth: 1)
        )
)
```

## Screen Layouts

### 1. Main Window
- Minimum size: 1200×800 pixels
- Hidden title bar for maximum space
- Full-screen background gradient
- Fixed header, scrollable content

### 2. Header Bar
- Height: ~60pt
- Glass effect background
- Left-aligned title
- Right-aligned stats and action button

### 3. Empty State
- Centered content
- Large icon (80pt)
- Clear call-to-action
- Minimalist layout

### 4. Table View
- **Header Row**: Fixed, scrollable horizontally
  - Column name with sort indicator
  - Type indicator (numeric icon)
  - Filter field per column
  - Width: 180pt per column

- **Data Rows**: Scrollable vertically and horizontally
  - Alternating row background (3% white opacity)
  - Border between rows (5% white opacity)
  - Monospaced font for alignment

### 5. Analytics View
- **Grid Layout**: 2 columns
- **Card Spacing**: 20pt
- **Chart Cards**:
  - Padding: 20pt
  - Rounded corners: 16pt radius
  - Glass background with border
  - Drop shadow for depth

### 6. Chart Components
- **Stats Row**: Horizontal layout of stat boxes
  - Min (Blue), Mean (Cyan), Max (Green)
  - Monospaced values
  - Glass background

- **Chart Area**:
  - Height: 250pt
  - Dark background (20% black)
  - White grid lines (10% opacity)
  - Cyan/Blue gradients for data
  - Rounded corners: 12pt

## Animation & Interaction

### Transitions
- Button hover: Subtle scale and opacity change
- Tab switching: Smooth fade transition
- Filter updates: Immediate, no animation
- Sort indicator: Instant update

### Interactive Elements
- **Clickable**: Column headers, buttons, tabs
- **Hoverable**: All interactive elements show feedback
- **Focus States**: Subtle glow effect

## Accessibility

### Color Contrast
- All text meets WCAG AA standards
- Important data uses high contrast (90% white on dark)
- Secondary info uses lower contrast (60% white)

### Visual Hierarchy
1. Primary actions (Import button) - Bright gradient
2. Data headers - Bold, white
3. Data values - Monospaced, slightly dimmed
4. Labels - Small, low opacity

### Icon Usage
- Magnifying glass: Search/Filter
- Number icon: Numeric column indicator
- Chart icons: Different visualization types
- Arrow indicators: Sort direction
- Plus/Upload: Import action

## Bloomberg Terminal Inspiration

Elements borrowed from Bloomberg Terminal:
1. **Dark Theme**: Reduces eye strain during extended use
2. **Monospaced Data**: Ensures alignment and scannability
3. **Dense Information**: Maximum data in minimum space
4. **Color Coding**: Cyan for values, colors for metrics
5. **Professional Typography**: Clear, readable, business-focused
6. **Grid Layouts**: Organized, structured information display

## macOS Native Elements

Following Apple's Human Interface Guidelines:
1. **SF Symbols**: Native icon system
2. **Materials**: System-provided glass effects
3. **Rounded Corners**: Consistent with macOS Big Sur+
4. **Tab Interface**: Standard macOS pattern
5. **File Picker**: Native NSOpenPanel
6. **Window Chrome**: Hidden title bar style

## Responsive Behavior

### Minimum Sizes
- Window: 1200×800pt
- Column: 180pt
- Chart card: 400×400pt

### Scaling
- Text scales with system settings
- Layouts adapt to window size
- Charts resize proportionally
- Grid adjusts column count on narrow windows

## Future Design Considerations

- Custom themes (light mode)
- User-configurable colors
- Adjustable density settings
- Custom keyboard shortcuts
- Drag-and-drop column reordering
