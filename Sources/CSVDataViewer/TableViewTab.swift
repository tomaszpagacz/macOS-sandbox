import SwiftUI

struct TableViewTab: View {
    @ObservedObject var viewModel: CSVDataViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            // Column headers with filters
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(viewModel.columns) { column in
                        VStack(spacing: 8) {
                            // Column header with sort
                            Button(action: {
                                viewModel.toggleSort(for: column.name)
                            }) {
                                HStack(spacing: 4) {
                                    Text(column.name)
                                        .font(.system(size: 12, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    if column.isNumeric {
                                        Image(systemName: "number")
                                            .font(.system(size: 10))
                                            .foregroundColor(.cyan)
                                    }
                                    
                                    if viewModel.sortColumn == column.name {
                                        Image(systemName: viewModel.sortAscending ? "chevron.up" : "chevron.down")
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundColor(.blue)
                                    }
                                }
                                .frame(width: 180, alignment: .leading)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                            }
                            .buttonStyle(.plain)
                            
                            // Data quality chart
                            DataQualityChart(viewModel: viewModel, column: column)
                                .frame(width: 180)
                        }
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.ultraThinMaterial)
                                .opacity(0.3)
                        )
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 100)
            .background(
                GlassmorphismBackground(opacity: 0.1)
            )
            
            // Data rows
            ScrollView([.horizontal, .vertical]) {
                VStack(spacing: 0) {
                    ForEach(Array(viewModel.sortedCsvData.enumerated()), id: \.element.id) { index, row in
                        HStack(spacing: 0) {
                            ForEach(viewModel.columns) { column in
                                Text(row.values[column.name] ?? "")
                                    .font(.system(size: 11, design: .monospaced))
                                    .foregroundColor(.white.opacity(0.9))
                                    .frame(width: 180, alignment: .leading)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(
                                        Rectangle()
                                            .fill(index % 2 == 0 ? Color.white.opacity(0.03) : Color.clear)
                                    )
                            }
                        }
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.white.opacity(0.05)),
                            alignment: .bottom
                        )
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)
                    .opacity(0.2)
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .opacity(0.1)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

// Custom filter text field with glassmorphism
struct FilterTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 10))
                .foregroundColor(.white.opacity(0.5))
            
            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
                .font(.system(size: 11, design: .rounded))
                .foregroundColor(.white)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.white.opacity(0.5))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(.ultraThinMaterial)
                .opacity(0.3)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                .stroke(.white.opacity(0.2), lineWidth: 1)
            )
        )
    }
}

// Data quality chart for table columns
struct DataQualityChart: View {
    let viewModel: CSVDataViewModel
    let column: ColumnInfo
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(.ultraThinMaterial)
                .opacity(0.3)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
            
            if column.isNumeric {
                numericQualityView
            } else {
                stringQualityView
            }
        }
        .frame(height: 40)
    }
    
    private var numericQualityView: some View {
        HStack(spacing: 8) {
            if let range = viewModel.getColumnRange(for: column.name) {
                MiniHistogramView(values: viewModel.csvData.compactMap { row in
                    Double(row.values[column.name] ?? "")
                }, minValue: range.min, maxValue: range.max)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(String(format: "%.1f - %.1f", range.min, range.max))
                        .font(.system(size: 9, design: .monospaced))
                        .foregroundColor(.cyan)
                    Text("\(viewModel.csvData.count) values")
                        .font(.system(size: 8, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
        }
        .padding(.horizontal, 8)
    }
    
    private var stringQualityView: some View {
        HStack(spacing: 8) {
            if let info = viewModel.getStringColumnInfo(for: column.name) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(info.uniqueCount) unique")
                        .font(.system(size: 9, design: .rounded))
                        .foregroundColor(.cyan)
                    if let top = info.topValues.first {
                        Text("Top: \(top.value)")
                            .font(.system(size: 8, design: .rounded))
                            .foregroundColor(.white.opacity(0.6))
                            .lineLimit(1)
                    }
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

// Mini histogram for numeric columns
struct MiniHistogramView: View {
    let values: [Double]
    let minValue: Double
    let maxValue: Double
    
    private var bins: [Int] {
        let binCount = 10
        var bins = Array(repeating: 0, count: binCount)
        
        for value in values {
            let binIndex = Swift.min(Int((value - minValue) / (maxValue - minValue) * Double(binCount)), binCount - 1)
            bins[binIndex] += 1
        }
        
        return bins
    }
    
    private var maxBin: Int {
        bins.max() ?? 1
    }
    
    var body: some View {
        HStack(spacing: 1) {
            ForEach(bins.indices, id: \.self) { index in
                Rectangle()
                    .fill(.cyan.opacity(0.6))
                    .frame(width: 3, height: CGFloat(bins[index]) / CGFloat(maxBin) * 30)
                    .frame(maxHeight: 30, alignment: .bottom)
            }
        }
    }
}

#Preview {
    let viewModel = CSVDataViewModel()
    return TableViewTab(viewModel: viewModel)
}
