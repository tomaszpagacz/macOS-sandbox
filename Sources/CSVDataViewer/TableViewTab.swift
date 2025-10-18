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
                            
                            // Filter field
                            FilterTextField(
                                placeholder: "Filter...",
                                text: Binding(
                                    get: { viewModel.columnFilters[column.name] ?? "" },
                                    set: { viewModel.setFilter(for: column.name, text: $0) }
                                )
                            )
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
                    ForEach(Array(viewModel.filteredData.enumerated()), id: \.element.id) { index, row in
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

#Preview {
    let viewModel = CSVDataViewModel()
    return TableViewTab(viewModel: viewModel)
}
