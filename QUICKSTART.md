# Quick Start Guide

Get up and running with CSV Data Viewer in 5 minutes!

## 📥 Installation

### Prerequisites
- macOS 14.0 (Sonoma) or later
- Xcode 15.0 or later (for building from source)

### Build & Run

```bash
# Clone the repository
git clone https://github.com/tomaszpagacz/macOS-sandbox.git
cd macOS-sandbox

# Open in Xcode
xed .

# Press ⌘R to build and run
```

## 🚀 First Steps

### 1. Launch the App
When you first open CSV Data Viewer, you'll see an elegant dark interface with a "Import CSV" button.

### 2. Import Sample Data
Try the included sample data:
- Click "Choose CSV File"
- Navigate to the project folder
- Select `sample_data.csv`
- Data loads instantly!

### 3. Explore the Table
- **Scroll** through the data
- **Click headers** to sort
- **Type in filters** to search
- Notice the smooth animations!

### 4. View Analytics
- Click the **"Analytics"** tab
- See automatic charts for:
  - Age distribution
  - Salary ranges
  - Years of experience
  - Performance scores
- Switch between **Bar, Line, and Area** charts

## 🎯 Common Tasks

### Filtering Data
```
Task: Find all Engineers making over $80,000

1. In the "Department" filter: type "Engineering"
2. In the "Salary" filter: type "8" (shows 80k+)
3. See results instantly!
```

### Sorting
```
Task: Find highest paid employee

1. Click the "Salary" column header
2. Click again for descending order
3. Top entry is highest paid!
```

### Analyzing Distributions
```
Task: Understand salary distribution

1. Switch to "Analytics" tab
2. Find the "Salary" chart card
3. Check the histogram (Bar chart)
4. Note Min, Mean, and Max values
```

## 📊 Your Own Data

### CSV Format
Your CSV should look like this:
```csv
Column1,Column2,Column3
Value1,Value2,Value3
Value1,Value2,Value3
```

**Tips:**
- First row = column names
- Use commas to separate values
- Numbers without formatting (no $, commas)
- Save as UTF-8 encoding

### Example Files to Try

**Sales Data:**
```csv
Date,Product,Units_Sold,Revenue,Region
2024-01-01,Widget A,150,7500,North
2024-01-02,Widget B,200,10000,South
2024-01-03,Widget A,175,8750,East
```

**Student Grades:**
```csv
Student_Name,Math,Science,English,GPA
Alice,95,88,92,3.9
Bob,78,85,80,3.2
Charlie,88,92,85,3.6
```

## 🎨 Design Features

### Glassmorphism
Notice the beautiful frosted glass effects:
- Header bar
- Filter boxes
- Chart cards
- All with subtle transparency and blur

### Bloomberg-Inspired
Professional features:
- Dark theme reduces eye strain
- Monospaced numbers align perfectly
- Cyan highlights draw attention
- Dense information layout

### Smooth Interactions
Every interaction is polished:
- Instant filter updates
- Smooth scrolling
- Fluid animations
- Native macOS feel

## ⚡ Pro Tips

### Performance
- App handles thousands of rows smoothly
- Large files? Filter first, then analyze
- Only visible rows are rendered

### Keyboard Navigation
- **⌘O**: Import file
- **⌘1**: Data Table tab
- **⌘2**: Analytics tab
- **Tab**: Move between filters

### Best Practices
1. **Name columns clearly**: "Total_Sales" not "Column3"
2. **Clean your data**: Remove special characters from numbers
3. **Use consistent formats**: All dates same style
4. **Test with sample**: Try on small file first

## 🐛 Troubleshooting

### Nothing appears after import?
- Check your CSV has data rows (not just headers)
- Verify it's actually comma-separated
- Try opening in TextEdit to check format

### No charts showing?
- Check if columns contain numbers
- Remove text from numeric columns
- Try the sample data to verify app works

### Filter not finding results?
- Check for extra spaces in data
- Remember filter is case-insensitive
- Try shorter search terms

## 📚 Next Steps

### Learn More
- **[User Guide](USER_GUIDE.md)**: Complete feature documentation
- **[Design Guide](DESIGN.md)**: Customization options
- **[Contributing](CONTRIBUTING.md)**: Help improve the app

### Use Cases
- **Business**: Sales analysis, employee data
- **Academic**: Student grades, research data
- **Personal**: Budget tracking, fitness logs
- **Development**: Test data visualization

### Get Help
- Check the [User Guide](USER_GUIDE.md)
- Open an issue on GitHub
- Read the [FAQ](USER_GUIDE.md#troubleshooting)

## 🎉 You're Ready!

That's it! You now know how to:
- ✅ Import CSV files
- ✅ Filter and sort data
- ✅ Generate charts
- ✅ Analyze distributions

Enjoy using CSV Data Viewer! 📊✨

---

**Made with ❤️ for macOS**
