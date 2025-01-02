//
//  LocationFindView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import SwiftUI
import MapKit

struct LocationFindView : SheetView {
    var sheetTitle: String {
        "Location Sheet"
    }
    
    //https://hackernoon.com/address-autocompletion-using-swiftui-and-mapkit
        
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
        @FocusState private var isFocusedTextField: Bool
        

    var confirmButton: some View {
        Text("Confirm Button")
    }
    var content: some View {
                VStack(alignment: .leading, spacing: 0) {

                    TextField("Type address", text: $viewModel.searchableText)
                        .padding()
                        .autocorrectionDisabled()
                        .focused($isFocusedTextField)
                        .font(.title2)
                        .onReceive(
                            viewModel.$searchableText.debounce(
                                for: .seconds(1),
                                scheduler: DispatchQueue.main
                            )
                        ) {
                            viewModel.searchAddress($0)
                        }
                        //.background(Color.init(uiColor: .systemBackground))
                        .overlay {
                            ClearButton(text: $viewModel.searchableText)
                                .padding(.trailing)
                                .padding(.top, 8)
                        }
                        .onAppear {
                            isFocusedTextField = true
                        }

                    List(self.viewModel.results) { address in
                        AddressRow(address: address)
                           // .listRowBackground(.blue)
                    }
                    //.listStyle(.plain)
                    //.scrollContentBackground(.hidden)
                }
               // .background(.blue)
                .edgesIgnoringSafeArea(.bottom)
            }
        
        
    }


struct ClearButton: View {
    
    @Binding var text: String
    
    var body: some View {
        if text.isEmpty == false {
            HStack {
                Spacer()
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                }
                .foregroundColor(.secondary)
            }
        } else {
            EmptyView()
        }
    }
}

struct AddressRow: View {
    
    let address: AddressResult
    
    var body: some View {
        NavigationLink {
            ClassicMapView(address: address)
        } label: {
            VStack(alignment: .leading) {
                Text(address.title)
                Text(address.subtitle)
                    .font(.caption)
            }
        }
        .padding(.bottom, 2)
    }
}

struct ClassicMapView: View {
    
    @StateObject private var viewModel : MapViewModel
    
    private let address: AddressResult
    
    private let title : String
    
    init(address: AddressResult) {
        self.address = address
        self._viewModel = StateObject(wrappedValue: MapViewModel())
        self.title = address.title
    }
    
    private var cameraBinding: Binding<MapCameraPosition> {
        Binding(
            get: {
                .region(viewModel.region)
            },
            set: { newValue in
                if let region = newValue.region {
                    viewModel.region = region
                }
            }
        )
    }
    
    var body: some View {
        Map(position: cameraBinding) {
            ForEach(viewModel.annotationItems, id: \.id) { item in
                Marker(title, coordinate: item.coordinate)
            }
        }
        .onAppear {
            viewModel.getPlace(from: address)

        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
