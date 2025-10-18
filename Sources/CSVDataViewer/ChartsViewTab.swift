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
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 20),
                    GridItem(.flexible(), spacing: 20)
                ], spacing: 20) {
                    ForEach(viewModel.numericColumns) { column in
                        ChartCard(
                            columnName: column.name,
                            stats: viewModel.getColumnStats(for: column.name)
                        )
                    }
                }
                .padding()
            }
        }
    }
}

struct ChartCard: View {
    let columnName: String
    let stats: ColumnStats?
    @State private var chartType: ChartType = .bar
    
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
                        Text("n=\(stats.count)")
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
                            .foregroundColor(.cyan)
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
    
    private var chartData: [(bin: String, count: Int)] {
        let binCount = min(20, stats.values.count)
        let range = stats.max - stats.min
        let binSize = range / Double(binCount)
        
        var bins: [Int] = Array(repeating: 0, count: binCount)
        
        for value in stats.values {
            let binIndex = min(Int((value - stats.min) / binSize), binCount - 1)
            bins[binIndex] += 1
        }
        
        return bins.enumerated().map { index, count in
            let binStart = stats.min + Double(index) * binSize
            return (bin: String(format: "%.1f", binStart), count: count)
        }
    }
    
    var body: some View {
        Chart(chartData, id: \.bin) { item in
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
            AxisMarks(preset: .aligned, values: .stride(by: 4)) { _ in
                AxisValueLabel()
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 9, design: .monospaced))
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
