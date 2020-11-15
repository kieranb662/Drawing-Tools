// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI
import Shapes

struct ConcaveStem: View {
    var width: CGFloat = 100
    let standardWidth: CGFloat = 100
    var scaleFactor: CGFloat {
        width != 0 ? width/standardWidth : 1
    }
    var trapezoid1Size: CGSize = CGSize(width: 50, height: 10)
    var rectSize: CGSize       = CGSize(width: 55, height: 10)
    var trapezoid2Size: CGSize = CGSize(width: 100, height: 100)
    var baseSize: CGSize       = CGSize(width: 100, height: 40)
    
    var trapezoid1Curvature: CGFloat = 0.05
    var trapezoid1BaseRatio: CGFloat = 0.9
    
    var trapezoid2Curvature: CGFloat = 0.2
    var trapezoid2BaseRatio: CGFloat = 0.55
    
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
        var rectColor: Color
        var trapezoid2Color: Color
        var baseColor: Color
        
        init(
            trapezoid1Color: Color = Color(white: 0.05),
            rectColor: Color       = Color(white: 0.2),
            trapezoid2Color: Color = Color(white: 0.1),
            baseColor: Color       = Color(white: 0.2)
        ) {
            self.trapezoid1Color = trapezoid1Color
            self.rectColor = rectColor
            self.trapezoid2Color = trapezoid2Color
            self.baseColor = baseColor
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            trapezoid1
            rect
            trapezoid2
            base
        }
    }
    
    var trapezoid1: some View {
        Trapezoid(baseRatio: trapezoid1BaseRatio, curvature: trapezoid1Curvature)
            .fill(style.trapezoid1Color)
            .frame(width: scaleFactor*trapezoid1Size.width,
                   height: scaleFactor*trapezoid1Size.height)
    }
    
    var rect: some View {
        OmniRectangle(topLeft: .round(radius: 2),
                      topRight: .round(radius: 2),
                      bottomLeft: .square,
                      bottomRight: .square)
            .fill(style.rectColor)
            .frame(width: scaleFactor*rectSize.width,
                   height: scaleFactor*rectSize.height)
    }
    
    var trapezoid2: some View {
        Trapezoid(baseRatio: trapezoid2BaseRatio, curvature: trapezoid2Curvature)
            .fill(style.trapezoid2Color)
            .frame(width: scaleFactor*trapezoid2Size.width,
                   height: scaleFactor*trapezoid2Size.height)
    }
    
    var base: some View {
        Rectangle()
            .fill(style.baseColor)
            .frame(width: scaleFactor*baseSize.width,
                   height: scaleFactor*baseSize.height)
    }
}

extension ConcaveStem: DrawingToolComponent {
    var terminalWidth: CGFloat {
        scaleFactor*trapezoid1Size.width*trapezoid1BaseRatio
    }
}

struct ConcaveStem_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ConcaveStem()
            ConcaveStem(width: 150)
            ConcaveStem(width: 50)
        }
    }
}
