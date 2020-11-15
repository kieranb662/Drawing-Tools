// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI
import Shapes

struct TieredStem: View {
    var width: CGFloat = 90
    private let standardWidth: CGFloat = 90
    private var scaleFactor: CGFloat {
        width != 0 ? width/standardWidth : 1
    }
    private let antennaSize: CGSize    = CGSize(width: 15, height: 30)
    private let trapezoid1Size: CGSize = CGSize(width: 40, height: 10)
    private let tier1Size: CGSize      = CGSize(width: 40, height: 10)
    private let tier2Size: CGSize      = CGSize(width: 50, height: 10)
    private let trapezoid2Size: CGSize = CGSize(width: 75, height: 125)
    private let tier3Size: CGSize      = CGSize(width: 90, height: 25)
    private let antennaCornerRadius: CGFloat = 2
    private let trapezoid1BaseRatio: CGFloat = 0.5
    private let tier2CornerRadius: CGFloat = 3
    private let trapezoid2BaseRatio: CGFloat = 0.8
    private let tier3CornerRadius: CGFloat = 2
    private let bandThickness: CGFloat = 3
    private var style: Style
    
    init(width: CGFloat = 100) {
        self.width = width
        self.style = .init()
    }
    
    init(width: CGFloat = 100, style: Style = .init()) {
        self.width = width
        self.style = style
    }
    
    struct Style {
        var antennaColor: Color
        var trapezoid1Color: Color
        var tier1Color: Color
        var tier1TopColor: Color
        var tier1BottomColor: Color
        var tier2Color: Color
        var tier2BottomColor: Color
        var trapezoid2Color: Color
        var tier3Color: Color
        var tier3BottomColor: Color
        var bandColor: Color
        
        public init(
            antennaColor: Color     = .gray,
            trapezoid1Color: Color  = Color(white: 0.4),
            tier1Color: Color       = Color(white: 0.2),
            tier1TopColor: Color    = Color(white: 0.3),
            tier1BottomColor: Color = Color(white: 0.3),
            tier2Color: Color       = Color(white: 0.05),
            tier2BottomColor: Color = Color(white: 0.3),
            trapezoid2Color: Color  = Color(white: 0.05),
            tier3Color: Color       = Color(white: 0.2),
            tier3BottomColor: Color = Color(white: 0.3),
            bandColor: Color        = Color(white: 0.05)
        ) {
            self.antennaColor = antennaColor
            self.trapezoid1Color = trapezoid1Color
            self.tier1Color = tier1Color
            self.tier1TopColor = tier1TopColor
            self.tier1BottomColor = tier1BottomColor
            self.tier2Color = tier2Color
            self.tier2BottomColor = tier2BottomColor
            self.trapezoid2Color = trapezoid2Color
            self.tier3Color = tier3Color
            self.tier3BottomColor = tier3BottomColor
            self.bandColor = bandColor
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            antenna
            trapezoid1
            tier1
            tier2
            trapezoid2
            tier3
        }
    }
    
    var antenna: some View {
        OmniRectangle(topLeft: .round(radius: antennaCornerRadius),
                      topRight: .round(radius: antennaCornerRadius),
                      bottomLeft: .square,
                      bottomRight: .square)
            .fill(style.antennaColor)
            .frame(width: scaleFactor*antennaSize.width, height: scaleFactor*antennaSize.height)
    }
    
    var trapezoid1: some View {
        Trapezoid(baseRatio: trapezoid1BaseRatio)
            .fill(style.trapezoid1Color)
            .frame(width: scaleFactor*trapezoid1Size.width, height: scaleFactor*trapezoid1Size.height)
    }
    
    var tier1: some View {
        Rectangle()
            .fill(style.tier1Color)
            .overlay(HorizontalLine(offset: 0)
                        .stroke(style.tier1TopColor, style: StrokeStyle(lineCap: .butt)), alignment: .top)
            .overlay(HorizontalLine(offset: 1)
                        .stroke(style.tier1BottomColor), alignment: .bottom)
            .frame(width: scaleFactor*tier1Size.width, height: scaleFactor*tier1Size.height)
    }
    
    var tier2: some View {
        OmniRectangle(topLeft: .round(radius: tier2CornerRadius),
                      topRight: .round(radius: tier2CornerRadius),
                      bottomLeft: .square,
                      bottomRight: .square)
            .fill(style.tier2Color)
            .frame(width: scaleFactor*tier2Size.width, height: scaleFactor*tier2Size.height)
            .overlay(HorizontalLine(offset: 1)
                        .stroke(style.tier2BottomColor),
                     alignment: .bottom)
    }
    
    var trapezoid2: some View {
        Trapezoid(baseRatio: trapezoid2BaseRatio)
            .fill(style.trapezoid2Color)
            .frame(width: scaleFactor*trapezoid2Size.width, height: scaleFactor*trapezoid2Size.height)
    }
    
    var tier3: some View {
        OmniRectangle(topLeft: .round(radius: tier3CornerRadius),
                      topRight: .round(radius: tier3CornerRadius),
                      bottomLeft: .square,
                      bottomRight: .square)
            .fill(style.tier3Color)
            .frame(width: scaleFactor*tier3Size.width, height: scaleFactor*tier3Size.height)
            .overlay(HorizontalLine(offset: 0.3)
                        .stroke(style.bandColor, lineWidth: bandThickness))
    }
    
}

extension TieredStem: DrawingToolComponent {
    var terminalWidth: CGFloat {
        scaleFactor*antennaSize.width
    }
}

struct TieredStem_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            TieredStem()
            TieredStem(width: 200)
            TieredStem(width: 50)
        }
    }
}
