//
//  OpenInMaps.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import SwiftUI

struct MiniOpenInMapButton : View {
    let lat : Double
    
    var body : some View {
        HStack {
            Button {
                
            } label: {
                Label("Car", systemImage: "car.circle")
            }
            Button {
                
            } label: {
                Label("Ride", systemImage: "figure.walk.circle")
            }
        }
    }
}

struct OpenInMapsButton: View {
    var location: JourneyStepLocation

    @ViewBuilder
    var body: some View {
        Section {
            button(for: .car)
        }
        Section {
            button(for: .walk)
        }
    }

    private func button(for type: JourneyType) -> some View {
        Button {
            UIApplication.shared
                .open(appleUrl(for: type)!, options: [:], completionHandler: nil)
        } label: {
            ZStack {
                type.getColor()
                    .opacity(0.7)
                    .background(.thickMaterial)

                HStack {
                    VStack {
                        Image(systemName: "map")
                            .foregroundStyle(.thinMaterial)
                            .font(.title)
                        Image(systemName: type.getSymbolName())
                            .foregroundStyle(.ultraThinMaterial)
                            .font(.title)
                    }
                    VStack {
                        Text("Open Maps")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .foregroundStyle(.ultraThickMaterial)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
            }
        }
        .contentShape(Rectangle())
        .buttonStyle(PlainButtonStyle())
        .removeListRowPaddingInsets()
    }

    private var canOpenAppleMaps: Bool {
        UIApplication.shared.canOpenURL(appleUrl(for: .car)!)
    }

    private func appleUrl(for type: JourneyType) -> URL? {
        URL(string: "maps://?saddr=&daddr=\(location.latitude),\(location.longitude)&dirflg=\(type.getCode())")
    }
}

private enum JourneyType: String {
    case car = "d"
    case walk = "w"
    case transit = "r"
}

extension JourneyType {
    func getCode() -> String {
        return rawValue
    }

    func getSymbolName() -> String {
        switch self {
        case .car:
            return "car.fill"
        case .walk:
            return "figure.walk.motion"
        case .transit:
            return "bus.fill"
        }
    }

    func getColor() -> Color {
        switch self {
        case .car:
            return .pink
        case .walk:
            return .green
        case .transit:
            return .teal
        }
    }
}
