import SwiftUI
import Charts

struct ChartsViewTab: View {
    @ObservedObject var viewModel: CSVDataViewModel
    
    var body: some View {
        ScrollView {
            if viewModel.numericColumns.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "chart.bar.xaxis")
                        .font(.system(size: 60))
                        .foregroundColor(.white.opacity(0.3))
                    
                    Text("No Numeric Columns Found")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("The imported CSV file doesn't contain any numeric columns to visualize")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            } else {
                // Filters section
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Filters")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        if !viewModel.analyticsFilters.isEmpty {
                            Text("(\(viewModel.analyticsFilters.count) active)")
                                .font(.system(size: 12, design: .rounded))
                                .foregroundColor(.cyan)
                            
                            Button("Clear All") {
                                viewModel.clearAllAnalyticsFilters()
                            }
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.red.opacity(0.6))
                            .cornerRadius(4)
                            .buttonStyle(.plain)
                        }
                    }
                    
                    HStack(spacing: 16) {
                        ForEach(viewModel.columns) { column in
                            AnalyticsFilterView(viewModel: viewModel, column: column)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 20),
                    GridItem(.flexible(), spacing: 20)
                ], spacing: 20) {
                    ForEach(viewModel.numericColumns) { column in
                        ChartCard(
                            viewModel: viewModel,
                            columnName: column.name
                        )
                    }
                }
                .padding()
            }
        }
    }
}

struct ChartCard: View {
    @ObservedObject var viewModel: CSVDataViewModel
    let columnName: String
    @State private var chartType: ChartType = .bar
    
    private var stats: ColumnStats? {
        let result = viewModel.getColumnStats(for: columnName)
        print("ChartCard(\(columnName)): Recalculating stats - count: \(result?.count ?? 0)")
        return result
    }
    
    enum ChartType: String, CaseIterable {
        case bar = "Bar"
        case line = "Line"
        case area = "Area"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(columnName)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    if let stats = stats {
                        HStack(spacing: 8) {
                            Text("n=\(stats.count)")
                                .font(.system(size: 10, weight: .medium, design: .monospaced))
                                .foregroundColor(.cyan)
                            
                            if viewModel.analyticsFilters.isEmpty == false {
                                Text("(filtered)")
                                    .font(.system(size: 9, design: .rounded))
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                }
                
                Spacer()
                
                // Chart type picker
                Picker("", selection: $chartType) {
                    ForEach(ChartType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 180)
            }
            
            // Statistics
            if let stats = stats {
                HStack(spacing: 20) {
                    StatBox(label: "Min", value: String(format: "%.2f", stats.min), color: .blue)
                    StatBox(label: "Mean", value: String(format: "%.2f", stats.mean), color: .cyan)
                    StatBox(label: "Max", value: String(format: "%.2f", stats.max), color: .green)
                }
            }
            
            // Chart
            if let stats = stats {
                ZStack {
                    // Chart background
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.black.opacity(0.2))
                    
                    // Chart content
                    Group {
                        switch chartType {
                        case .bar:
                            BarChartView(stats: stats)
                        case .line:
                            LineChartView(stats: stats)
                        case .area:
                            AreaChartView(stats: stats)
                        }
                    }
                    .padding()
                }
                .frame(height: 250)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .opacity(0.2)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                colors: [.white.opacity(0.3), .white.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
        )
    }
}

struct StatBox: View {
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.6))
            
            Text(value)
                .font(.system(size: 14, weight: .bold, design: .monospaced))
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.ultraThinMaterial)
                .opacity(0.3)
        )
    }
}

// Bar Chart
struct BarChartView: View {
    let stats: ColumnStats
    
    private var chartData: [(id: Int, bin: String, count: Int)] {
        let binCount = min(20, stats.values.count)
        let range = stats.max - stats.min
        
        // Handle case where all values are the same
        if range == 0 {
            return [(id: 0, bin: String(format: "%.2f", stats.min), count: stats.values.count)]
        }
        
        let binSize = range / Double(binCount)
        
        var bins: [Int] = Array(repeating: 0, count: binCount)
        
        for value in stats.values {
            let binIndex = min(Int((value - stats.min) / binSize), binCount - 1)
            bins[binIndex] += 1
        }
        
        return bins.enumerated().map { index, count in
            let binStart = stats.min + Double(index) * binSize
            return (id: index, bin: String(format: "%.2f", binStart), count: count)
        }
    }
    
    var body: some View {
        Chart(chartData, id: \.id) { item in
            BarMark(
                x: .value("Bin", item.bin),
                y: .value("Count", item.count)
            )
            .foregroundStyle(
                LinearGradient(
                    colors: [.cyan, .blue],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .chartXAxis {
            AxisMarks { _ in
                AxisValueLabel()
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 9, design: .monospaced))
                AxisGridLine()
                    .foregroundStyle(.white.opacity(0.1))
            }
        }
        .chartYAxis {
            AxisMarks { _ in
                AxisValueLabel()
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 9, design: .monospaced))
                AxisGridLine()
                    .foregroundStyle(.white.opacity(0.1))
            }
        }
    }
}

// Line Chart
struct LineChartView: View {
    let stats: ColumnStats
    
    private var chartData: [(index: Int, value: Double)] {
        Array(stats.values.enumerated().prefix(100).map { (index: $0, value: $1) })
    }
    
    var body: some View {
        Chart(chartData, id: \.index) { item in
            LineMark(
                x: .value("Index", item.index),
                y: .value("Value", item.value)
            )
            .foregroundStyle(.cyan)
            .lineStyle(StrokeStyle(lineWidth: 2))
            
            PointMark(
                x: .value("Index", item.index),
                y: .value("Value", item.value)
            )
            .foregroundStyle(.cyan)
        }
        .chartXAxis {
            AxisMarks { _ in
                AxisValueLabel()
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 9, design: .monospaced))
                AxisGridLine()
                    .foregroundStyle(.white.opacity(0.1))
            }
        }
        .chartYAxis {
            AxisMarks { _ in
                AxisValueLabel()
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 9, design: .monospaced))
                AxisGridLine()
                    .foregroundStyle(.white.opacity(0.1))
            }
        }
    }
}

// Area Chart
struct AreaChartView: View {
    let stats: ColumnStats
    
    private var chartData: [(index: Int, value: Double)] {
        Array(stats.values.enumerated().prefix(100).map { (index: $0, value: $1) })
    }
    
    var body: some View {
        Chart(chartData, id: \.index) { item in
            AreaMark(
                x: .value("Index", item.index),
                y: .value("Value", item.value)
            )
            .foregroundStyle(
                LinearGradient(
                    colors: [.cyan.opacity(0.8), .blue.opacity(0.3)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
            LineMark(
                x: .value("Index", item.index),
                y: .value("Value", item.value)
            )
            .foregroundStyle(.cyan)
            .lineStyle(StrokeStyle(lineWidth: 2))
        }
        .chartXAxis {
            AxisMarks { _ in
                AxisValueLabel()
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 9, design: .monospaced))
                AxisGridLine()
                    .foregroundStyle(.white.opacity(0.1))
            }
        }
        .chartYAxis {
            AxisMarks { _ in
                AxisValueLabel()
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 9, design: .monospaced))
                AxisGridLine()
                    .foregroundStyle(.white.opacity(0.1))
            }
        }
    }
}

#Preview {
    let viewModel = CSVDataViewModel()
    return ChartsViewTab(viewModel: viewModel)
}

// Analytics filter view for each column
struct AnalyticsFilterView: View {
    @ObservedObject var viewModel: CSVDataViewModel
    let column: ColumnInfo
    
    @State private var textFilter = ""
    @State private var minValue = ""
    @State private var maxValue = ""
    @State private var showSuggestions = false
    @State private var suggestions: [String] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(column.name)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
            
            if column.isNumeric {
                numericFilterView
            } else {
                stringFilterView
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.ultraThinMaterial)
                .opacity(0.3)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
        )
        .frame(width: 180)
    }
    
    private var numericFilterView: some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                TextField("Min", text: $minValue)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 11, design: .monospaced))
                
                TextField("Max", text: $maxValue)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 11, design: .monospaced))
            }
            
            HStack(spacing: 8) {
                Button("Apply") {
                    let min = Double(minValue.trimmingCharacters(in: .whitespaces))
                    let max = Double(maxValue.trimmingCharacters(in: .whitespaces))
                    viewModel.setAnalyticsFilter(for: column.name, filter: .range(min: min, max: max))
                }
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.cyan.opacity(0.6))
                .cornerRadius(4)
                .buttonStyle(.plain)
                
                Button("Clear") {
                    if let range = viewModel.getColumnRange(for: column.name) {
                        minValue = String(format: "%.2f", range.min)
                        maxValue = String(format: "%.2f", range.max)
                    }
                    viewModel.setAnalyticsFilter(for: column.name, filter: .range(min: nil, max: nil))
                }
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.red.opacity(0.6))
                .cornerRadius(4)
                .buttonStyle(.plain)
            }
        }
        .onAppear {
            if minValue.isEmpty && maxValue.isEmpty {
                if let range = viewModel.getColumnRange(for: column.name) {
                    minValue = String(format: "%.2f", range.min)
                    maxValue = String(format: "%.2f", range.max)
                }
            }
        }
    }
    
    private var stringFilterView: some View {
        VStack(spacing: 6) {
            HStack(spacing: 4) {
                TextField("Filter text...", text: $textFilter)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 11, design: .rounded))
                    .onChange(of: textFilter) { oldValue, newValue in
                        updateSuggestions(for: newValue)
                        viewModel.setAnalyticsFilter(for: column.name, filter: .text(newValue))
                    }
                
                if !textFilter.isEmpty {
                    Button(action: {
                        textFilter = ""
                        viewModel.setAnalyticsFilter(for: column.name, filter: .text(""))
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(.plain)
                }
            }
            
            if showSuggestions && !suggestions.isEmpty {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(suggestions, id: \.self) { suggestion in
                            Button(action: {
                                textFilter = suggestion
                                showSuggestions = false
                                viewModel.setAnalyticsFilter(for: column.name, filter: .text(suggestion))
                            }) {
                                Text(suggestion)
                                    .font(.system(size: 10, design: .rounded))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 4)
                            }
                            .buttonStyle(.plain)
                            .background(Color.black.opacity(0.2))
                        }
                    }
                }
                .frame(height: 100)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.black.opacity(0.7))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.white.opacity(0.3), lineWidth: 1)
                        )
                )
            }
        }
    }
    
    private func updateSuggestions(for prefix: String) {
        suggestions = viewModel.getStringFilterSuggestions(for: column.name, prefix: prefix)
        showSuggestions = !suggestions.isEmpty
    }
}
