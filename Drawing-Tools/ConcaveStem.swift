// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct ConcaveStem: View {
    
    var trapezoid1Color: Color = .black
    var trapezoid1Curvature: CGFloat = 0.05
    var trapezoid1BaseRatio: CGFloat = 0.9
    var trapezoid1Size: CGSize = CGSize(width: 50, height: 10)
    
    var rectColor: Color = Color(white: 0.2)
    var rectSize: CGSize = CGSize(width: 55, height: 10)
    
    var trapezoid2Color: Color = Color(white: 0.1)
    var trapezoid2Curvature: CGFloat = 0.2
    var trapezoid2BaseRatio: CGFloat = 0.55
    var trapezoid2Size: CGSize = CGSize(width: 100, height: 100)
    
    var baseColor: Color = Color(white: 0.2)
    var baseSize: CGSize = CGSize(width: 100, height: 40)
    
    var shaftSize: CGSize = CGSize(width: 110, height: 300)
    var shaftCornerRadius: CGFloat = 5
    
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
            .fill(trapezoid1Color)
            .frame(width: trapezoid1Size.width, height: trapezoid1Size.height)
    }
    
    var rect: some View {
        OmniRectangle(topLeft: .round(radius: 2),
                      topRight: .round(radius: 2),
                      bottomLeft: .square,
                      bottomRight: .square)
            .fill(rectColor)
            .frame(width: rectSize.width, height: rectSize.height)
    }
    
    var trapezoid2: some View {
        Trapezoid(baseRatio: trapezoid2BaseRatio, curvature: trapezoid2Curvature)
            .fill(trapezoid2Color)
            .frame(width: trapezoid2Size.width, height: trapezoid2Size.height)
    }
    
    var base: some View {
        Rectangle()
            .fill(baseColor)
            .frame(width: baseSize.width, height: baseSize.height)
    }
}

struct ConcaveStem_Previews: PreviewProvider {
    static var previews: some View {
        ConcaveStem()
    }
}
