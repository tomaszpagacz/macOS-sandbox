import Foundation
import AppKit

// CSV Data Model
struct CSVRow: Identifiable {
    let id = UUID()
    let values: [String: String]
}

// Column information
struct ColumnInfo: Identifiable {
    let id = UUID()
    let name: String
    let isNumeric: Bool
}

// Filter types for analytics
enum AnalyticsFilter {
    case text(String)
    case range(min: Double?, max: Double?)
}

// CSV Data View Model
@MainActor
class CSVDataViewModel: ObservableObject {
    @Published var csvData: [CSVRow] = []
    @Published var columns: [ColumnInfo] = []
    @Published var columnFilters: [String: String] = [:] // For table filtering
    @Published var analyticsFilters: [String: AnalyticsFilter] = [:] // For analytics filtering
    @Published var sortColumn: String?
    @Published var sortAscending = true
    
    var filteredData: [CSVRow] {
        var result = csvData
        
        // Apply filters
        for (column, filterText) in columnFilters where !filterText.isEmpty {
            result = result.filter { row in
                guard let value = row.values[column] else { return false }
                return value.localizedCaseInsensitiveContains(filterText)
            }
        }
        
        // Apply sorting
        if let sortColumn = sortColumn {
            result.sort { row1, row2 in
                guard let val1 = row1.values[sortColumn],
                      let val2 = row2.values[sortColumn] else {
                    return false
                }
                
                // Check if both values are numeric
                if let num1 = Double(val1), let num2 = Double(val2) {
                    return sortAscending ? num1 < num2 : num1 > num2
                }
                
                // String comparison
                return sortAscending ? val1 < val2 : val1 > val2
            }
        }
        
        return result
    }
    
    var numericColumns: [ColumnInfo] {
        columns.filter { $0.isNumeric }
    }
    
    var analyticsFilteredData: [CSVRow] {
        var result = csvData
        
        print("analyticsFilteredData: Starting with \(result.count) rows, \(analyticsFilters.count) filters")
        
        // Apply analytics filters
        for (column, filter) in analyticsFilters {
            result = result.filter { row in
                guard let value = row.values[column] else { return false }
                
                switch filter {
                case .text(let text):
                    return text.isEmpty || value.localizedCaseInsensitiveContains(text)
                case .range(let min, let max):
                    guard let numValue = Double(value.trimmingCharacters(in: .whitespaces)) else { return false }
                    if let min = min, numValue < min { return false }
                    if let max = max, numValue > max { return false }
                    return true
                }
            }
            print("After filtering \(column): \(result.count) rows remaining")
        }
        
        print("analyticsFilteredData: Final count = \(result.count)")
        return result
    }
    
    var sortedCsvData: [CSVRow] {
        var result = csvData
        
        // Apply sorting
        if let sortColumn = sortColumn {
            result.sort { row1, row2 in
                guard let val1 = row1.values[sortColumn],
                      let val2 = row2.values[sortColumn] else {
                    return false
                }
                
                // Check if both values are numeric
                if let num1 = Double(val1), let num2 = Double(val2) {
                    return sortAscending ? num1 < num2 : num1 > num2
                }
                
                // String comparison
                return sortAscending ? val1 < val2 : val1 > val2
            }
        }
        
        return result
    }
    
    func importCSV() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.allowedContentTypes = [.commaSeparatedText, .plainText]
        panel.message = "Select a CSV file to import"
        
        if panel.runModal() == .OK, let url = panel.url {
            parseCSV(from: url)
        }
    }
    
    private func parseCSV(from url: URL) {
        do {
            let content = try String(contentsOf: url, encoding: .utf8)
            let lines = content.components(separatedBy: .newlines)
                .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
            
            guard !lines.isEmpty else { return }
            
            // Parse header
            let headers = parseCSVLine(lines[0])
            
            // Parse data rows
            var rows: [CSVRow] = []
            for i in 1..<lines.count {
                let values = parseCSVLine(lines[i])
                if values.count == headers.count {
                    var rowDict: [String: String] = [:]
                    for (index, header) in headers.enumerated() {
                        rowDict[header] = values[index]
                    }
                    rows.append(CSVRow(values: rowDict))
                }
            }
            
            // Determine column types
            var columnInfos: [ColumnInfo] = []
            for header in headers {
                let isNumeric = rows.allSatisfy { row in
                    guard let value = row.values[header] else { return false }
                    return Double(value.trimmingCharacters(in: .whitespaces)) != nil
                }
                columnInfos.append(ColumnInfo(name: header, isNumeric: isNumeric))
            }
            
            self.columns = columnInfos
            self.csvData = rows
            self.columnFilters = [:]
            self.analyticsFilters = [:]
            self.sortColumn = nil
        } catch {
            print("Error reading CSV: \(error)")
        }
    }
    
    private func parseCSVLine(_ line: String) -> [String] {
        var result: [String] = []
        var currentField = ""
        var insideQuotes = false
        
        for char in line {
            if char == "\"" {
                insideQuotes.toggle()
            } else if char == "," && !insideQuotes {
                result.append(currentField.trimmingCharacters(in: .whitespaces))
                currentField = ""
            } else {
                currentField.append(char)
            }
        }
        
        result.append(currentField.trimmingCharacters(in: .whitespaces))
        return result
    }
    
    func setAnalyticsFilter(for column: String, filter: AnalyticsFilter) {
        // Remove empty filters
        switch filter {
        case .text(let text) where text.isEmpty:
            analyticsFilters.removeValue(forKey: column)
        case .range(let min, let max) where min == nil && max == nil:
            analyticsFilters.removeValue(forKey: column)
        default:
            analyticsFilters[column] = filter
        }
        objectWillChange.send() // Force update
        print("Filter set for \(column): \(filter)")
        print("Total active filters: \(analyticsFilters.count)")
    }
    
    func clearAllAnalyticsFilters() {
        analyticsFilters.removeAll()
        objectWillChange.send()
        print("All filters cleared")
    }
    
    func getStringFilterSuggestions(for column: String, prefix: String) -> [String] {
        let uniqueValues = Set(csvData.compactMap { $0.values[column] })
        return uniqueValues
            .filter { $0.localizedCaseInsensitiveContains(prefix) }
            .sorted()
            .prefix(10)
            .map { $0 }
    }
    
    func getColumnRange(for column: String) -> (min: Double, max: Double)? {
        guard let columnInfo = columns.first(where: { $0.name == column }),
              columnInfo.isNumeric else { return nil }
        
        let values = csvData.compactMap { row -> Double? in
            guard let valueStr = row.values[column] else { return nil }
            return Double(valueStr.trimmingCharacters(in: .whitespaces))
        }
        
        guard let min = values.min(), let max = values.max() else { return nil }
        return (min, max)
    }
    
    func getStringColumnInfo(for column: String) -> (uniqueCount: Int, topValues: [(value: String, count: Int)])? {
        guard let columnInfo = columns.first(where: { $0.name == column }),
              !columnInfo.isNumeric else { return nil }
        
        let values = csvData.compactMap { $0.values[column] }
        let valueCounts = Dictionary(values.map { ($0, 1) }, uniquingKeysWith: +)
        let sorted = valueCounts.sorted { $0.value > $1.value }
        let topValues = sorted.prefix(5).map { (value: $0.key, count: $0.value) }
        
        return (uniqueCount: valueCounts.count, topValues: topValues)
    }
    
    func toggleSort(for column: String) {
        if sortColumn == column {
            sortAscending.toggle()
        } else {
            sortColumn = column
            sortAscending = true
        }
    }
    
    func getColumnStats(for columnName: String) -> ColumnStats? {
        guard let column = columns.first(where: { $0.name == columnName }),
              column.isNumeric else {
            return nil
        }
        
        let values = analyticsFilteredData.compactMap { row -> Double? in
            guard let valueStr = row.values[columnName] else { return nil }
            return Double(valueStr.trimmingCharacters(in: .whitespaces))
        }
        
        guard !values.isEmpty else { return nil }
        
        let sorted = values.sorted()
        let sum = sorted.reduce(0, +)
        let mean = sum / Double(sorted.count)
        let min = sorted.first ?? 0
        let max = sorted.last ?? 0
        
        return ColumnStats(
            columnName: columnName,
            min: min,
            max: max,
            mean: mean,
            count: sorted.count,
            values: sorted
        )
    }
}

// Statistics for numeric columns
struct ColumnStats {
    let columnName: String
    let min: Double
    let max: Double
    let mean: Double
    let count: Int
    let values: [Double]
}
