//
//  AnimatedBackGroundView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 20/03/2025.
//

import SwiftUI

protocol AnimatedBackGroundView: View {
    var colours: [Color] { get }
    var backgroundColor: Color { get }

    var isAssistiveAccessEnabled: Bool { get }
}

extension AnimatedBackGroundView {
    func shiftHue(of color: Color, by amount: Double) -> Color {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        UIColor(color).getHue(
            &hue, saturation: &saturation, brightness: &brightness,
            alpha: &alpha
        )

        hue += CGFloat(amount)
        hue = hue.truncatingRemainder(dividingBy: 1.0)

        if hue < 0 {
            hue += 1
        }

        return Color(
            hue: Double(hue), saturation: Double(saturation),
            brightness: Double(brightness), opacity: Double(alpha)
        )
    }

    @ViewBuilder
    var meshGradient: some View {
        if isAssistiveAccessEnabled {
            backgroundColor.opacity(0.7)
                .ignoresSafeArea()

        } else {
            TimelineView(.animation) { timeline in
                MeshGradient(
                    width: 3,
                    height: 3,
                    locations: .points(points),
                    colors: .colors(animatedColours(for: timeline.date)),
                    background: backgroundColor,
                    smoothsColors: true
                )
            }
            .ignoresSafeArea()
        }
    }

    var points: [SIMD2<Float>] { [
        SIMD2<Float>(0.0, 0.0), SIMD2<Float>(0.5, 0.0), SIMD2<Float>(1.0, 0.0),
        SIMD2<Float>(0.0, 0.5), SIMD2<Float>(0.5, 0.5), SIMD2<Float>(1.0, 0.5),
        SIMD2<Float>(0.0, 1.0), SIMD2<Float>(0.5, 1.0), SIMD2<Float>(1.0, 1.0),
    ]
    }

    func animatedColours(for date: Date) -> [Color] {
        let phase = CGFloat(date.timeIntervalSince1970)

        return colours.enumerated().map { index, color in
            let hueShift = cos(phase + Double(index) * 0.3) * 0.1
            return shiftHue(of: color, by: hueShift)
        }
    }
}
