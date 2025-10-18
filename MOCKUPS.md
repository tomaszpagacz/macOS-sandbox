# Visual Mockups & Screenshots

Since this is a macOS application built with SwiftUI, here are detailed descriptions and ASCII representations of what the application looks like.

## 1. Application Window - Initial State

```
┌────────────────────────────────────────────────────────────────┐
│  CSV Data Viewer                          [Import CSV] ⬆️      │
│ ───────────────────────────────────────────────────────────── │
│                                                                │
│                                                                │
│                         📄                                     │
│                                                                │
│              Import CSV to Begin                               │
│                                                                │
│      Upload a CSV file to visualize data with                 │
│         interactive tables and charts                          │
│                                                                │
│                  [Choose CSV File ⬆️]                          │
│                                                                │
│                                                                │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

**Visual Details:**
- **Background**: Deep navy gradient (RGB 5,5,20 to 13,13,38)
- **Icon**: Large document icon with finder (80pt, white, 30% opacity)
- **Title**: 28pt, bold, rounded font, white
- **Description**: 16pt, white at 60% opacity
- **Button**: Cyan-to-blue gradient with white border, 16pt text
- **Glassmorphism**: Frosted glass effect on header bar

## 2. Table View - With Data Loaded

```
┌────────────────────────────────────────────────────────────────┐
│  CSV Data Viewer          150 rows × 6 cols  [Import New] ⬆️  │
│ ───────────────────────────────────────────────────────────── │
│  [Data Table] 📊    [Analytics] 📈                             │
│ ───────────────────────────────────────────────────────────── │
│                                                                │
│ ┌─────────────┬─────────────┬─────────────┬─────────────┐    │
│ │Employee_Name│  Age 🔢 ↑  │ Salary 🔢   │ Department  │    │
│ │             │             │             │             │    │
│ │[🔍 Filter..]│[🔍 Filter..]│[🔍 Filter..]│[🔍 Filter..]│    │
│ ├─────────────┼─────────────┼─────────────┼─────────────┤    │
│ │ John Smith  │     35      │   75000     │ Engineering │    │
│ ├─────────────┼─────────────┼─────────────┼─────────────┤    │
│ │ Jane Doe    │     28      │   65000     │  Marketing  │    │
│ ├─────────────┼─────────────┼─────────────┼─────────────┤    │
│ │Robert John..│     42      │   85000     │ Engineering │    │
│ ├─────────────┼─────────────┼─────────────┼─────────────┤    │
│ │ Emily Davis │     31      │   70000     │    Sales    │    │
│ ├─────────────┼─────────────┼─────────────┼─────────────┤    │
│ │Michael Wils.│     39      │   92000     │ Engineering │    │
│ ├─────────────┼─────────────┼─────────────┼─────────────┤    │
│ │ Sarah Brown │     26      │   58000     │  Marketing  │    │
│ └─────────────┴─────────────┴─────────────┴─────────────┘    │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

**Visual Details:**
- **Header Row**: 
  - Glass background with subtle border
  - Bold column names (12pt, rounded font)
  - Number icon (🔢) for numeric columns
  - Sort arrow (↑↓) on active sort column
  - Cyan highlight on numeric indicators
  
- **Filter Boxes**:
  - Magnifying glass icon (🔍)
  - Placeholder text "Filter..."
  - Glass background (ultra-thin material)
  - Border radius: 6pt
  - Width: 180pt per column
  
- **Data Rows**:
  - Alternating background (3% white opacity)
  - Monospaced font (11pt SF Mono)
  - White text at 90% opacity
  - Subtle borders between rows (5% white)
  
- **Scrolling**: 
  - Smooth momentum scrolling
  - Both horizontal and vertical
  - Native macOS scroll indicators

## 3. Analytics View - Charts Grid

```
┌────────────────────────────────────────────────────────────────┐
│  CSV Data Viewer          150 rows × 6 cols  [Import New] ⬆️  │
│ ───────────────────────────────────────────────────────────── │
│  [Data Table] 📊    [Analytics] 📈                             │
│ ───────────────────────────────────────────────────────────── │
│                                                                │
│  ┌──────────────────────────┐ ┌──────────────────────────┐   │
│  │ Age              n=150   │ │ Salary           n=150   │   │
│  │ [Bar][Line][Area]        │ │ [Bar][Line][Area]        │   │
│  │                          │ │                          │   │
│  │ [Min: 26][Mean: 33][Max:45]│[Min: 58K][Mean:75K][Max:95K]│
│  │                          │ │                          │   │
│  │     ▂▄▆█▆▄▂             │ │      ▂▄█▇▅▃▂            │   │
│  │    ▁▃▅▇███▇▅▃▁          │ │     ▁▃▆███▇▅▃▁         │   │
│  │   ▁▂▄▆████▆▄▂▁         │ │    ▁▃▅████▇▅▃▁        │   │
│  │  ▁▂▃▅██████▅▃▂▁        │ │   ▁▃▅██████▇▅▃▁       │   │
│  │ ▁▂▃▄███████▄▃▂▁       │ │  ▁▂▄███████▇▄▂▁      │   │
│  │▁▂▃▄████████▄▃▂▁      │ │ ▁▂▄████████▇▄▂▁     │   │
│  └──────────────────────────┘ └──────────────────────────┘   │
│                                                                │
│  ┌──────────────────────────┐ ┌──────────────────────────┐   │
│  │ Years_Experience n=150   │ │ Performance     n=150    │   │
│  │ [Bar][Line][Area]        │ │ [Bar][Line][Area]        │   │
│  │                          │ │                          │   │
│  │ [Min: 3][Mean: 9][Max:18]│ │[Min: 4.0][Mean:4.4][Max:4.9]│
│  │                          │ │                          │   │
│  │      ▄▆█▆▄▂             │ │       ▂▄▆█▆▄▂           │   │
│  │     ▂▅███▇▅▃            │ │      ▁▃▅███▇▅▃▁        │   │
│  │    ▁▄██████▄▁           │ │     ▁▃▅██████▅▃▁       │   │
│  │   ▂▅████████▅▂          │ │    ▁▃▅████████▅▃▁      │   │
│  │  ▁▄███████████▄▁        │ │   ▁▃▅█████████▅▃▁     │   │
│  │ ▁▃██████████████▃▁      │ │  ▁▃▅██████████▅▃▁    │   │
│  └──────────────────────────┘ └──────────────────────────┘   │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

**Visual Details:**

### Chart Cards:
- **Background**: Glass effect with gradient border
- **Padding**: 20pt all around
- **Corner Radius**: 16pt
- **Shadow**: Black at 30% opacity, 20pt blur
- **Border**: White gradient (30% to 10% opacity)

### Chart Header:
- **Title**: Column name, 16pt bold rounded font, white
- **Count**: "n=150", 10pt monospaced, cyan color
- **Type Picker**: Segmented control, 180pt wide
  - Options: [Bar] [Line] [Area]
  - Blue background when selected
  - Glass background when not selected

### Statistics Row:
- **Layout**: 3 equal-width boxes horizontally
- **Each Box**:
  - Label: 10pt, white at 60%
  - Value: 14pt bold monospaced
  - Min: Blue color
  - Mean: Cyan color
  - Max: Green color
  - Background: Glass effect
  - Corner radius: 8pt

### Chart Area:
- **Height**: 250pt
- **Background**: Black at 20% opacity, rounded 12pt
- **Axes**:
  - Labels: 9pt monospaced, white at 60%
  - Grid lines: White at 10% opacity
  
- **Bar Chart**:
  - Bars: Cyan to blue gradient (top to bottom)
  - Width: Auto-adjusted based on bins
  - 20 bins maximum
  
- **Line Chart**:
  - Line: 2pt stroke, cyan color
  - Points: Cyan circles
  - Up to 100 points displayed
  
- **Area Chart**:
  - Fill: Cyan (80%) to blue (30%) gradient
  - Line: 2pt stroke, cyan
  - Same point limit as line chart

## 4. Filtered State Example

```
┌────────────────────────────────────────────────────────────────┐
│  CSV Data Viewer           3 rows × 6 cols   [Import New] ⬆️  │
│ ───────────────────────────────────────────────────────────── │
│  [Data Table] 📊    [Analytics] 📈                             │
│ ───────────────────────────────────────────────────────────── │
│                                                                │
│ ┌─────────────┬─────────────┬─────────────┬─────────────┐    │
│ │Employee_Name│  Age 🔢     │ Salary 🔢 ↓ │ Department  │    │
│ │             │             │             │             │    │
│ │[🔍        ]│[🔍 3    ⊗]│[🔍 8    ⊗]│[🔍 eng  ⊗]│    │
│ ├─────────────┼─────────────┼─────────────┼─────────────┤    │
│ │Michael Wils.│     39      │   92000     │ Engineering │    │
│ ├─────────────┼─────────────┼─────────────┼─────────────┤    │
│ │Robert John..│     42      │   85000     │ Engineering │    │
│ ├─────────────┼─────────────┼─────────────┼─────────────┤    │
│ │ John Smith  │     35      │   75000     │ Engineering │    │
│ └─────────────┴─────────────┴─────────────┴─────────────┘    │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

**Visual Details:**
- **Active Filters**: Show filter text with clear button (⊗)
- **Result Count**: Updates in header (3 rows × 6 cols)
- **Sort Indicator**: Shows descending arrow (↓) on Salary
- **Clear Button**: Circle-X icon, appears on hover, white at 50%

## 5. Empty Numeric Columns State

```
┌────────────────────────────────────────────────────────────────┐
│  CSV Data Viewer          150 rows × 3 cols  [Import New] ⬆️  │
│ ───────────────────────────────────────────────────────────── │
│  [Data Table] 📊    [Analytics] 📈                             │
│ ───────────────────────────────────────────────────────────── │
│                                                                │
│                                                                │
│                         📊                                     │
│                                                                │
│              No Numeric Columns Found                          │
│                                                                │
│     The imported CSV file doesn't contain any                 │
│        numeric columns to visualize                            │
│                                                                │
│                                                                │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

## Color Palette Reference

### Backgrounds
```
Primary Background:     #050514  (RGB: 5, 5, 20)
Secondary Background:   #0D0D26  (RGB: 13, 13, 38)
Glass Material:         ultraThinMaterial at 10-30% opacity
Card Background:        Black at 20% opacity
```

### Accents
```
Primary Cyan:           #00D9FF  (RGB: 0, 217, 255)
Secondary Blue:         #0099FF  (RGB: 0, 153, 255)
Success Green:          #00FF88  (RGB: 0, 255, 136)
```

### Text
```
Primary Text:           White at 90% opacity
Secondary Text:         White at 60% opacity
Tertiary Text:          White at 50% opacity
Disabled Text:          White at 30% opacity
```

### Borders & Strokes
```
Primary Border:         White at 30% opacity
Secondary Border:       White at 20% opacity
Grid Lines:             White at 10% opacity
Dividers:               White at 5% opacity
```

## Animations

### Hover Effects
- **Buttons**: Scale 1.02, increase glow
- **Filter Fields**: Border glow increases
- **Chart Type Picker**: Subtle background highlight

### Transitions
- **Tab Switch**: 0.3s fade with ease-in-out
- **Filter Results**: Instant update (no animation)
- **Sort Toggle**: Instant update (no animation)
- **Chart Type Change**: 0.2s cross-fade

### Loading States
- **File Import**: Native file picker (no custom UI)
- **Data Parse**: Instant for typical CSV files
- **Chart Render**: Smooth native animation

## Responsive Behavior

### Minimum Window Size: 1200 × 800
```
Width < 1200:  2-column chart grid becomes 1-column
Width < 800:   Columns in table may be cut off (scroll required)
Height < 800:  Vertical scrolling required
```

### Maximum Display
- No maximum width limit
- No maximum height limit
- Charts scale proportionally
- Table expands to fill space

## Interaction States

### Button States
```
Normal:     Gradient background, white text
Hover:      Slightly brighter, scale 1.02
Active:     Slightly dimmer
Disabled:   50% opacity, no interaction
```

### Input Field States
```
Normal:     Glass background, placeholder visible
Focus:      Brighter border, cursor visible
Filled:     Clear button appears
Error:      (Not implemented - no validation)
```

### Chart Card States
```
Normal:     Glass effect, shadow
Hover:      Slightly brighter border
Active:     (No active state - read-only)
```

## Accessibility

### VoiceOver Labels
- "Import CSV button"
- "Filter by [Column Name]"
- "Sort by [Column Name]"
- "[Column Name] chart, showing [min] to [max]"

### Color Contrast
- All text meets WCAG AA standards
- Primary text: 13.5:1 ratio
- Secondary text: 8.1:1 ratio
- Interactive elements: Minimum 4.5:1

### Keyboard Navigation
- Tab through all interactive elements
- Enter to activate buttons
- Space to select segmented controls
- Arrow keys in table (planned)

---

## Design Inspiration Sources

### Bloomberg Terminal Elements
- Dark professional theme
- Dense information layout
- Monospaced data alignment
- Cyan/blue accent colors
- Focus on readability

### macOS Native Design
- SF Pro and SF Mono fonts
- Native materials and blur
- Standard window chrome
- System icons (SF Symbols)
- Native scroll behavior

### Glassmorphism Principles
- Frosted glass backdrop blur
- Subtle transparency layers
- Light borders on dark backgrounds
- Depth through shadows
- Layered visual hierarchy

---

*Note: This is a text-based mockup. When built and run on macOS, the actual application features smooth animations, native macOS behaviors, and high-resolution rendering with proper anti-aliasing and material effects.*
