import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @StateObject private var viewModel = CSVDataViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // Background gradient - Bloomberg Terminal inspired
            LinearGradient(
                colors: [
                    Color(red: 0.02, green: 0.02, blue: 0.08),
                    Color(red: 0.05, green: 0.05, blue: 0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header with upload functionality
                headerView
                
                if viewModel.csvData.isEmpty {
                    // Empty state
                    emptyStateView
                } else {
                    // Content area with tabs
                    TabView(selection: $selectedTab) {
                        TableViewTab(viewModel: viewModel)
                            .tabItem {
                                Label("Data Table", systemImage: "tablecells")
                            }
                            .tag(0)
                        
                        ChartsViewTab(viewModel: viewModel)
                            .tabItem {
                                Label("Analytics", systemImage: "chart.bar.fill")
                            }
                            .tag(1)
                    }
                    .padding()
                }
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("CSV Data Viewer")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Spacer()
            
            if !viewModel.csvData.isEmpty {
                Text("\(viewModel.csvData.count) rows × \(viewModel.columns.count) columns")
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white.opacity(0.1))
                    )
            }
            
            Button(action: { viewModel.importCSV() }) {
                Label(viewModel.csvData.isEmpty ? "Import CSV" : "Import New", systemImage: "doc.badge.plus")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(
                                    colors: [Color.blue.opacity(0.8), Color.cyan.opacity(0.6)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white.opacity(0.3), lineWidth: 1)
                            )
                    )
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(
            GlassmorphismBackground(opacity: 0.15)
        )
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text.viewfinder")
                .font(.system(size: 80))
                .foregroundColor(.white.opacity(0.3))
            
            Text("Import CSV to Begin")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text("Upload a CSV file to visualize data with interactive tables and charts")
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.6))
                .multilineTextAlignment(.center)
            
            Button(action: { viewModel.importCSV() }) {
                Label("Choose CSV File", systemImage: "arrow.up.doc")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [Color.blue.opacity(0.8), Color.cyan.opacity(0.6)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.white.opacity(0.3), lineWidth: 1)
                            )
                            .shadow(color: .blue.opacity(0.3), radius: 20, x: 0, y: 10)
                    )
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// Glassmorphism background component
struct GlassmorphismBackground: View {
    let opacity: Double
    
    var body: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .opacity(opacity)
            .overlay(
                Rectangle()
                    .stroke(
                        LinearGradient(
                            colors: [.white.opacity(0.3), .white.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .background(.black.opacity(0.1))
    }
}

#Preview {
    ContentView()
}
