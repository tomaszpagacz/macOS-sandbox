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

// CSV Data View Model
@MainActor
class CSVDataViewModel: ObservableObject {
    @Published var csvData: [CSVRow] = []
    @Published var columns: [ColumnInfo] = []
    @Published var columnFilters: [String: String] = [:]
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
    
    func setFilter(for column: String, text: String) {
        columnFilters[column] = text
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
        
        let values = csvData.compactMap { row -> Double? in
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
