// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI
import Shapes

struct GemStem: View {
    var width: CGFloat = 90
    private let standardWidth: CGFloat = 90
    var scaleFactor: CGFloat {
        width != 0 ? width/standardWidth : 1
    }
    var trapezoid1Size: CGSize = CGSize(width: 35, height: 10)
    var trapezoid2Size: CGSize = CGSize(width: 35, height: 25)
    var trapezoid3Size: CGSize = CGSize(width: 90, height: 120)
    var baseSize: CGSize       = CGSize(width: 90, height: 20)
    
    var trapezoid1Curvature: CGFloat = 0
    var trapezoid1BaseRatio: CGFloat = 0.7
    
    var trapezoid2Curvature: CGFloat = 0
    var trapezoid2BaseRatio: CGFloat = 0.8
    
    var trapezoid3Curvature: CGFloat = 0
    var trapezoid3BaseRatio: CGFloat = 0.4
    
    var style: Style
    
    init(width: CGFloat = 90) {
        self.width = width
        self.style = .init()
    }
    
    init(width: CGFloat = 90, style: Style = .init()) {
        self.width = width
        self.style = style
    }
    
    struct Style {
        var trapezoid1Color: Color
        var trapezoid2Color: Color
        var trapezoid3Color: Color
        var baseColor: Color
        
        public init(
            trapezoid1Color: Color = Color(white: 0.4),
            trapezoid2Color: Color = Color(white: 0.3),
            trapezoid3Color: Color = Color(white: 0.2),
            baseColor: Color       = Color(white: 0.3)
        ) {
            self.trapezoid1Color = trapezoid1Color
            self.trapezoid2Color = trapezoid2Color
            self.trapezoid3Color = trapezoid3Color
            self.baseColor = baseColor
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            trapezoid1
            trapezoid2
            trapezoid3
            base
        }
    }
    
    var trapezoid1: some View {
        Trapezoid(baseRatio: trapezoid1BaseRatio, curvature: trapezoid1Curvature)
            .fill(style.trapezoid1Color)
            .frame(width: scaleFactor*trapezoid1Size.width,
                   height: scaleFactor*trapezoid1Size.height)
    }
    
    
    var trapezoid2: some View {
        let transform = CGAffineTransform(a: 1, b: 0,
                                          c: 0, d: -1,
                                          tx: 0, ty: scaleFactor*trapezoid2Size.height)
        
        return Trapezoid(baseRatio: trapezoid2BaseRatio, curvature: trapezoid2Curvature)
            .transform(transform)
            .fill(style.trapezoid2Color)
            .frame(width: scaleFactor*trapezoid2Size.width,
                   height: scaleFactor*trapezoid2Size.height)
    }
    
    var trapezoid3: some View {
        Trapezoid(baseRatio: trapezoid3BaseRatio, curvature: trapezoid3Curvature)
            .fill(style.trapezoid3Color)
            .overlay(
                Trapezoid(baseRatio: trapezoid3BaseRatio,
                          curvature: trapezoid3Curvature)
                    .strokeBorder(style.trapezoid3Color, style: StrokeStyle(lineWidth: 5, lineJoin: .round))
            )
            .frame(width: scaleFactor*trapezoid3Size.width,
                   height: scaleFactor*trapezoid3Size.height)
    }
    
    var base: some View {
        Rectangle()
            .fill(style.baseColor)
            .frame(width: scaleFactor*baseSize.width,
                   height: scaleFactor*baseSize.height)
    }
}

extension GemStem: DrawingToolComponent {
    var terminalWidth: CGFloat {
        scaleFactor*trapezoid1Size.width*trapezoid1BaseRatio
    }
}

struct GemStem_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            GemStem()
            GemStem(width: 120)
            GemStem(width: 50)
        }
    }
}
