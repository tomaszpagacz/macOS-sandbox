import XCTest
@testable import CSVDataViewer

final class CSVDataViewModelTests: XCTestCase {
    var viewModel: CSVDataViewModel!
    
    @MainActor
    override func setUp() {
        super.setUp()
        viewModel = CSVDataViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    @MainActor
    func testInitialState() {
        XCTAssertTrue(viewModel.csvData.isEmpty, "Initial CSV data should be empty")
        XCTAssertTrue(viewModel.columns.isEmpty, "Initial columns should be empty")
        XCTAssertTrue(viewModel.columnFilters.isEmpty, "Initial filters should be empty")
        XCTAssertNil(viewModel.sortColumn, "Initial sort column should be nil")
        XCTAssertTrue(viewModel.sortAscending, "Initial sort order should be ascending")
    }
    
    @MainActor
    func testFilteredDataWithoutFilters() {
        // Given: Some test data
        let row1 = CSVRow(values: ["Name": "John", "Age": "30"])
        let row2 = CSVRow(values: ["Name": "Jane", "Age": "25"])
        viewModel.csvData = [row1, row2]
        
        // When: No filters are applied
        let filteredData = viewModel.filteredData
        
        // Then: All data should be returned
        XCTAssertEqual(filteredData.count, 2, "Filtered data should contain all rows")
    }
    
    @MainActor
    func testSetFilter() {
        // When: Setting a filter
        viewModel.setFilter(for: "Name", text: "John")
        
        // Then: Filter should be stored
        XCTAssertEqual(viewModel.columnFilters["Name"], "John", "Filter should be stored correctly")
    }
    
    @MainActor
    func testToggleSort() {
        // When: Toggling sort on a column
        viewModel.toggleSort(for: "Age")
        
        // Then: Sort column should be set and ascending
        XCTAssertEqual(viewModel.sortColumn, "Age", "Sort column should be set")
        XCTAssertTrue(viewModel.sortAscending, "First toggle should be ascending")
        
        // When: Toggling again
        viewModel.toggleSort(for: "Age")
        
        // Then: Sort should be descending
        XCTAssertFalse(viewModel.sortAscending, "Second toggle should be descending")
    }
    
    @MainActor
    func testNumericColumnDetection() {
        // Given: Columns with numeric and non-numeric data
        let numericColumn = ColumnInfo(name: "Age", isNumeric: true)
        let textColumn = ColumnInfo(name: "Name", isNumeric: false)
        viewModel.columns = [numericColumn, textColumn]
        
        // When: Getting numeric columns
        let numericColumns = viewModel.numericColumns
        
        // Then: Only numeric columns should be returned
        XCTAssertEqual(numericColumns.count, 1, "Should have one numeric column")
        XCTAssertEqual(numericColumns.first?.name, "Age", "Numeric column should be Age")
    }
    
    @MainActor
    func testGetColumnStatsForNonNumericColumn() {
        // Given: A non-numeric column
        let column = ColumnInfo(name: "Name", isNumeric: false)
        viewModel.columns = [column]
        
        // When: Getting stats for non-numeric column
        let stats = viewModel.getColumnStats(for: "Name")
        
        // Then: Stats should be nil
        XCTAssertNil(stats, "Stats should be nil for non-numeric columns")
    }
    
    @MainActor
    func testGetColumnStatsForNumericColumn() {
        // Given: A numeric column with data
        let column = ColumnInfo(name: "Age", isNumeric: true)
        viewModel.columns = [column]
        
        let row1 = CSVRow(values: ["Age": "30"])
        let row2 = CSVRow(values: ["Age": "25"])
        let row3 = CSVRow(values: ["Age": "35"])
        viewModel.csvData = [row1, row2, row3]
        
        // When: Getting stats for numeric column
        let stats = viewModel.getColumnStats(for: "Age")
        
        // Then: Stats should be calculated correctly
        XCTAssertNotNil(stats, "Stats should not be nil for numeric columns")
        XCTAssertEqual(stats?.min, 25.0, "Min should be 25")
        XCTAssertEqual(stats?.max, 35.0, "Max should be 35")
        XCTAssertEqual(stats?.mean, 30.0, "Mean should be 30")
        XCTAssertEqual(stats?.count, 3, "Count should be 3")
    }
}
