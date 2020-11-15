// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct BandedShaft<Fill: ShapeStyle>: View {
    var width: CGFloat = 100
    var bandThickness: CGFloat = 40
    var color: Color
    var opacity: Double = 1
    var fill: Fill
    
    init(color: Color, width: CGFloat = 50) where Fill == Color {
        self.color = color
        self.width = width
        self.fill = Color(white: 0.1)
    }
    
    init(color: Color, opacity: Double, width: CGFloat, bandThickness: CGFloat, shaftColor: Color = Color(white: 0.1)) where Fill == Color {
        self.color = color
        self.opacity = opacity
        self.width = width
        self.bandThickness = bandThickness
        self.fill = shaftColor
    }
    
    init(color: Color, opacity: Double, width: CGFloat, bandThickness: CGFloat, fill: Fill) {
        self.color = color
        self.opacity = opacity
        self.width = width
        self.bandThickness = bandThickness
        self.fill = fill
    }
    
    var body: some View {
        VStack(spacing: 0) {
            band
            shaft
        }
    }
    
    var band: some View {
        Rectangle()
            .fill(color)
            .frame(width: width, height: bandThickness)
    }
    
    var shaft: some View {
        Rectangle()
            .fill(fill)
            .frame(width: width)
    }
}

struct BandedShaft_Previews: PreviewProvider {
    static var previews: some View {
        BandedShaft(color: .purple)
    }
}
