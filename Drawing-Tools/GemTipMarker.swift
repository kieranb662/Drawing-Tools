// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct GemTipMarker: View {
    var tipTriangleColor: Color = Color.purple
    var tipTriangleSize: CGSize = CGSize(width: 20, height: 23)
    var tipRectSize: CGSize = CGSize(width: 20, height: 15)
    
    var tipTriangle: some View {
        Triangle()
            .fill(tipTriangleColor)
            .overlay(Triangle()
                        .strokeBorder(tipTriangleColor, style: StrokeStyle(lineWidth: 5, lineJoin: .round)))
            .frame(width: tipTriangleSize.width, height: tipTriangleSize.height)
            .offset(y: 2)
    }
    
    var tipRect: some View {
        Rectangle()
            .fill(tipTriangleColor)
            .overlay(Rectangle()
                        .strokeBorder(tipTriangleColor, style: StrokeStyle(lineWidth: 5, lineJoin: .round)))
            .brightness(0.05)
            .frame(width: tipRectSize.width, height: tipRectSize.height)
    }
    
    
    var trapezoid1Color: Color = Color(white: 0.4)
    var trapezoid1Curvature: CGFloat = 0
    var trapezoid1BaseRatio: CGFloat = 0.7
    var trapezoid1Size: CGSize = CGSize(width: 35, height: 10)
    
    var trapezoid1: some View {
        Trapezoid(baseRatio: trapezoid1BaseRatio, curvature: trapezoid1Curvature)
            .fill(trapezoid1Color)
            .frame(width: trapezoid1Size.width, height: trapezoid1Size.height)
    }
    
    var trapezoid2Color: Color = Color(white: 0.3)
    var trapezoid2Curvature: CGFloat = 0
    var trapezoid2BaseRatio: CGFloat = 0.8
    var trapezoid2Size: CGSize = CGSize(width: 35, height: 25)
    
    var trapezoid2: some View {
        Trapezoid(baseRatio: trapezoid2BaseRatio, curvature: trapezoid2Curvature)
            .transform(.init(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: trapezoid2Size.height))
            .fill(trapezoid2Color)
            .frame(width: trapezoid2Size.width, height: trapezoid2Size.height)
    }
    
    var trapezoid3Color: Color = Color(white: 0.2)
    var trapezoid3Curvature: CGFloat = 0
    var trapezoid3BaseRatio: CGFloat = 0.4
    var trapezoid3Size: CGSize = CGSize(width: 90, height: 120)
    
    var trapezoid3: some View {
        Trapezoid(baseRatio: trapezoid3BaseRatio, curvature: trapezoid3Curvature)
            .fill(trapezoid3Color)
            .overlay(Trapezoid(baseRatio: trapezoid3BaseRatio, curvature: trapezoid3Curvature)
                        .strokeBorder(trapezoid3Color, style: StrokeStyle(lineWidth: 5, lineJoin: .round)))
            .frame(width: trapezoid3Size.width, height: trapezoid3Size.height)
    }
    
    var baseColor: Color = Color(white: 0.3)
    var baseSize: CGSize = CGSize(width: 90, height: 20)
    
    var shaftSize: CGSize = CGSize(width: 110, height: 300)
    var shaftCornerRadius: CGFloat = 5
    
    var base: some View {
        Rectangle()
            .fill(baseColor)
            .frame(width: baseSize.width, height: baseSize.height)
    }
    
    var shaft: some View {
        RoundedRectangle(cornerRadius: shaftCornerRadius)
            .fill(tipTriangleColor)
            .frame(width: shaftSize.width, height: shaftSize.height)
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            tipTriangle
            tipRect
            trapezoid1
            trapezoid2
            trapezoid3
            base
            shaft
        }
    }
}

struct GemTip_Previews: PreviewProvider {
    static var previews: some View {
        GemTipMarker()
    }
}
