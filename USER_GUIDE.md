# User Guide - CSV Data Viewer

## Getting Started

### First Launch

1. **Open the Application**
   - Double-click the CSV Data Viewer app
   - You'll see the main window with a dark, professional interface

2. **Import Your First CSV File**
   - Click the "Import CSV" button in the top-right corner
   - Or use the keyboard shortcut: ⌘O (Command-O)
   - Select a CSV file from your computer
   - The app will automatically parse and display your data

### Understanding the Interface

#### Main Window
- **Header Bar**: Shows app title, data statistics, and import button
- **Tab Bar**: Switch between "Data Table" and "Analytics" views
- **Content Area**: Displays your data based on selected tab

## Working with Data Tables

### Viewing Data

Once you import a CSV file, you'll see:
- **Column Headers**: The first row of your CSV becomes the column headers
- **Data Rows**: All subsequent rows display as table data
- **Row Count**: Shows in the header (e.g., "150 rows × 6 columns")

### Filtering Data

Each column has a filter field:

1. **To Filter**:
   - Click in the filter box under any column
   - Type your search term
   - Data updates in real-time as you type

2. **Multiple Filters**:
   - You can filter multiple columns simultaneously
   - All filters are applied with AND logic

3. **Clear Filters**:
   - Click the ✕ button in the filter box
   - Or select all text and delete

**Example**:
- Filter "Department" by "Engineering"
- Filter "Age" by "3" (shows anyone in their 30s)
- Results show only Engineering employees in their 30s

### Sorting Data

Click on any column header to sort:

1. **First Click**: Sorts ascending (A→Z, 0→9)
2. **Second Click**: Sorts descending (Z→A, 9→0)
3. **Third Click**: Removes sort

**Visual Indicators**:
- ↑ Arrow: Ascending sort
- ↓ Arrow: Descending sort
- No arrow: Not sorted

**Numeric vs Text Sorting**:
- Numeric columns (marked with 🔢): Sort by numerical value
- Text columns: Sort alphabetically

### Scrolling

- **Vertical**: Scroll through rows
- **Horizontal**: Scroll through columns (if many columns exist)
- **Smooth Scrolling**: Uses macOS native momentum scrolling

## Using Analytics

Switch to the "Analytics" tab to see visualizations:

### Automatic Chart Generation

The app automatically creates charts for **all numeric columns**:
- Salary, Age, Years_Experience, Performance_Score, etc.

### Chart Types

Each chart card offers three visualization types:

1. **Bar Chart** (Histogram)
   - Shows distribution of values
   - Automatically bins data into ranges
   - Best for: Understanding value distribution

2. **Line Chart**
   - Shows values in sequence
   - Points connected by lines
   - Best for: Seeing trends and patterns

3. **Area Chart**
   - Filled line chart with gradient
   - Emphasizes volume
   - Best for: Visualizing cumulative patterns

**To Switch Chart Types**:
- Use the segmented control at the top of each chart card
- Changes apply instantly

### Understanding Statistics

Each chart displays key statistics:

- **Min**: Smallest value in the column
- **Mean**: Average value (sum ÷ count)
- **Max**: Largest value in the column
- **n=**: Number of data points

**Example**:
```
Salary
n=150

Min: $45,000    Mean: $75,000    Max: $125,000
```

### Chart Interactions

- **Grid Lines**: Help read exact values
- **Axes Labels**: Show value ranges
- **Color Coding**:
  - Cyan/Blue gradient: Primary data color
  - Matches the glassmorphism theme

## Tips & Tricks

### Efficient Data Analysis

1. **Quick Overview**:
   - Import file → Switch to Analytics tab
   - Scan all numeric columns at once
   - Identify outliers and patterns

2. **Deep Dive**:
   - Go to Data Table tab
   - Filter specific ranges
   - Sort by interesting columns

3. **Comparative Analysis**:
   - Filter by category (e.g., Department)
   - Check Analytics to see filtered data distribution

### Working with Large Files

- **Performance**: Optimized for thousands of rows
- **Lazy Loading**: Only renders visible rows
- **Smooth Scrolling**: Native macOS rendering

### CSV File Requirements

**Supported Format**:
```csv
Header1,Header2,Header3
Value1,Value2,Value3
Value1,Value2,Value3
```

**Requirements**:
- First row must be headers
- Comma-separated values
- Can include quoted fields: `"Value, with comma"`
- UTF-8 encoding recommended

**Not Supported**:
- Tab-separated values (TSV) - convert to CSV first
- Excel files (.xlsx) - export as CSV first
- Multiple sheets - save each sheet separately

## Keyboard Shortcuts

### Global
- **⌘O**: Open/Import CSV file
- **⌘W**: Close window
- **⌘Q**: Quit application
- **⌘,**: Preferences (if implemented)

### Navigation
- **⌘1**: Switch to Data Table tab
- **⌘2**: Switch to Analytics tab
- **Tab**: Move between filter fields
- **Arrow Keys**: Navigate table cells

### Data Manipulation
- **⌘F**: Focus on filter (if in table view)
- **Esc**: Clear focused filter
- **⌘A**: Select all text in filter

## Troubleshooting

### "No data appears after import"

**Possible causes**:
1. CSV file is empty
2. File has no data rows (only headers)
3. Encoding issue

**Solutions**:
- Open CSV in TextEdit to verify content
- Ensure file is UTF-8 encoded
- Check that first row contains headers

### "No numeric columns found"

**Cause**: All columns contain text data

**Solutions**:
- Verify numeric columns don't have text formatting
- Remove currency symbols ($, €) from numbers
- Remove commas from numbers (1,000 → 1000)
- Ensure consistent decimal notation (use . not ,)

### "Filter not working"

**Possible causes**:
1. Filter is case-sensitive
2. Extra spaces in data

**Note**: Filters are case-insensitive, but exact match required
- "eng" matches "Engineering" ✓
- "eng" matches "engineering" ✓
- "eng" matches "Engineer" ✓

### "Charts look empty"

**Possible causes**:
1. All values are the same (no distribution)
2. Very small number range
3. Too few data points

**Solutions**:
- Check if data has variance
- Try different chart type
- Verify data was imported correctly

## Advanced Features

### Working with Multiple Files

To compare different datasets:
1. Import first file
2. Take note of insights
3. Click "Import New" to load another file
4. Previous data is replaced (by design)

*Future versions may support multi-file comparison*

### Understanding Histogram Binning

Bar charts automatically create bins:
- **Maximum 20 bins** (adjustable in code)
- **Equal width bins** across value range
- **Count** shows how many values in each bin

Example for Salary data:
- Range: $45K - $125K (=$80K range)
- Bins: $45-49K, $50-54K, $55-59K, etc.

### Exporting Results

*Not yet implemented - coming soon*

Planned features:
- Export filtered data as new CSV
- Save chart images
- PDF report generation

## Best Practices

### Data Preparation

1. **Clean Headers**:
   - Use descriptive names: "Salary" not "Col3"
   - No special characters: Use underscores instead of spaces
   - Keep consistent: "Years_Experience" not "years exp"

2. **Consistent Formatting**:
   - All dates in same format
   - All numbers without formatting
   - Use empty cells for missing data, not "N/A" or "-"

3. **Numeric Data**:
   - Remove currency symbols
   - Remove thousands separators
   - Use consistent decimal notation

### Performance Tips

1. **Start Small**: Test with a sample of your data first
2. **Reduce Columns**: Only include necessary columns
3. **Clean Data**: Remove unnecessary formatting

### Visual Analysis

1. **Use Bar Charts**: To understand distribution
2. **Use Line Charts**: To see sequential patterns
3. **Use Area Charts**: To emphasize cumulative totals
4. **Compare Min/Mean/Max**: To identify outliers

## Support & Resources

### Getting Help

- **GitHub Issues**: Report bugs or request features
- **Documentation**: See README.md for technical details
- **Design Guide**: See DESIGN.md for customization

### Example Use Cases

1. **Sales Analysis**: Import sales data, filter by region, analyze trends
2. **Employee Records**: View demographics, salary distributions
3. **Performance Metrics**: Track KPIs across time periods
4. **Financial Data**: Analyze transactions, spending patterns
5. **Scientific Data**: Visualize measurements, experimental results

### Sample Data

The repository includes `sample_data.csv` with employee data:
- 15 employees
- 6 columns (Name, Age, Salary, Department, Experience, Performance)
- Mix of text and numeric data
- Perfect for testing features

## What's Next?

### Coming Soon
- Export functionality
- Custom themes
- More chart types
- Data aggregation
- Excel file support
- Cloud storage integration

### Your Feedback

Help improve CSV Data Viewer:
- Report bugs on GitHub
- Suggest features
- Share your use cases
- Contribute code

---

**Happy Data Analysis! 📊**
