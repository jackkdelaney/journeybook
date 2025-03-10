//
//  AddNewPhraseButton.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import SwiftUI

struct AddNewPhraseButton: View {
    @Binding var sheet: PhraseSheet?

    @State var animate = false

    var body: some View {
        Button {
            sheet = .addNewPhrase
        } label: {
            ZStack {
                meshGradient
                    .background(.ultraThickMaterial)

                HStack {
                    Image(systemName: "plus.circle.dashed")
                        .foregroundStyle(.thinMaterial)
                        .font(.largeTitle)
                    VStack {
                        Text("Add new Phrase")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        Text("Add New Phrase to Book")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .foregroundStyle(.ultraThickMaterial)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
            }
        }
        .contentShape(Rectangle())
        .removeListRowPaddingInsets()
        .buttonStyle(PlainButtonStyle())
    }

    private let colours: [Color] = [
        .purple,
        .pink,
        .indigo,

        .pink.opacity(0.8),
        .purple.opacity(0.8),
        .indigo.opacity(0.8),

        .purple.opacity(0.5),
        .pink.opacity(0.6),
        .indigo.opacity(0.6),
    ]

    private let points: [SIMD2<Float>] = [
        SIMD2<Float>(0.0, 0.0), SIMD2<Float>(0.5, 0.0), SIMD2<Float>(1.0, 0.0),
        SIMD2<Float>(0.0, 0.5), SIMD2<Float>(0.5, 0.5), SIMD2<Float>(1.0, 0.5),
        SIMD2<Float>(0.0, 1.0), SIMD2<Float>(0.5, 1.0), SIMD2<Float>(1.0, 1.0),
    ]

    private func animatedColours(for date: Date) -> [Color] {
        let phase = CGFloat(date.timeIntervalSince1970)

        return colours.enumerated().map { index, color in
            let hueShift = cos(phase + Double(index) * 0.3) * 0.1
            return shiftHue(of: color, by: hueShift)
        }
    }

    var meshGradient: some View {
        TimelineView(.animation) { timeline in
            MeshGradient(
                width: 3,
                height: 3,
                locations: .points(points),
                colors: .colors(animatedColours(for: timeline.date)),
                background: .black,
                smoothsColors: true
            )
        }
        .ignoresSafeArea()
    }

    private func shiftHue(of color: Color, by amount: Double) -> Color {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        UIColor(color).getHue(
            &hue, saturation: &saturation, brightness: &brightness,
            alpha: &alpha)

        hue += CGFloat(amount)
        hue = hue.truncatingRemainder(dividingBy: 1.0)

        if hue < 0 {
            hue += 1
        }

        return Color(
            hue: Double(hue), saturation: Double(saturation),
            brightness: Double(brightness), opacity: Double(alpha))
    }

}
