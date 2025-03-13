//
//  CountryCodeSelectorDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 12/03/2025.
//

import SwiftUI

struct CountryCodeSelectorDetailView:
    SheetView

{
    @Binding var countryCode: CountryWithCode?

    @State private var searchText = ""

    @Environment(\.dismiss) var dismiss

    private let customOrder: [Int] = [44, 353, 1, 33, 91, 86, 34, 350, 377, 379]

    var confirmButton: some View {
        Button("Clear", role: .destructive) {
            countryCode = nil
            dismiss()
        }
        .tint(.red)
    }

    var content: some View {
        List {
            ForEach(filteredSelection) { selectedItem in
                Button {
                    countryCode = selectedItem
                    dismiss()
                } label: {
                    VStack {
                        Text("\(selectedItem.countryName) (\(selectedItem.countryCode))")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("+\(selectedItem.dialCode)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .chevronButtonStyle()
            }
        }
        .searchable(text: $searchText)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(sheetTitle).font(.headline)
                    Text(sheetSubtitle).font(.caption)
                }
            }
        }
    }

    var sheetTitle: String {
        "Select Country Code"
    }

    private var sheetSubtitle: String {
        if let countryCode {
            "Currently Selected: \(countryCode.countryCode)"
        } else {
            "Please Select a Country Code"
        }
    }

    private var filteredSelection: [CountryWithCode] {
        if searchText.isEmpty {
            return CountryCodes.values().sorted { lhs, rhs in
                if let lhsIndex = customOrder.firstIndex(of: lhs.dialCodeInt), let rhsIndex = customOrder.firstIndex(of: rhs.dialCodeInt) {
                    return lhsIndex < rhsIndex
                } else if customOrder.contains(lhs.dialCodeInt) {
                    return true
                } else if customOrder.contains(rhs.dialCodeInt) {
                    return false
                } else {
                    return lhs.countryName < rhs.countryName
                }
            }

        } else {
            return CountryCodes.values().filter {
                $0.countryCode.lowercased().contains(searchText.lowercased()) || $0.countryName.lowercased().contains(searchText.lowercased()) || $0.dialCode.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

#Preview {
    NavigationView {
        CountryCodeSelectorDetailView(countryCode: .constant(CountryWithCode.example))
    }
}
