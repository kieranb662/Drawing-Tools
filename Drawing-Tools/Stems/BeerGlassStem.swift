// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI
import Shapes

struct BeerGlassStem<Fill: ShapeStyle, Stroke: ShapeStyle>: View {
    var width: CGFloat = 100
    private let standardWidth: CGFloat = 100
    private var scaleFactor: CGFloat {
        width != 0 ? width/standardWidth : 1
    }
    private let standardHeight: CGFloat = 150
    private let strokeStyle: StrokeStyle
    private let fill: Fill
    private let stroke: Stroke
    
    init(width: CGFloat = 100) where Fill == Color, Stroke == Color {
        self.width = width
        self.strokeStyle = StrokeStyle(lineWidth: 4, lineJoin: .round)
        self.fill = Color(white: 0.1)
        self.stroke = Color(white: 0.1)
    }
    
    init(width: CGFloat = 100,
         fill: Fill,
         stroke: Stroke,
         strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 4, lineJoin: .round)) {
        self.width = width
        self.strokeStyle = strokeStyle
        self.fill = fill
        self.stroke = stroke
    }
    
    var body: some View {
        BeerGlassShape()
            .fill(fill)
            .overlay(
                BeerGlassShape()
                    .strokeBorder(stroke, style: strokeStyle)
            )
            .frame(width: width, height: scaleFactor*standardHeight)
    }
}

extension BeerGlassStem: DrawingToolComponent {
    var terminalWidth: CGFloat {
        width*0.6
    }
}

struct BeerGlassStem_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            BeerGlassStem()
            BeerGlassStem(width: 200)
            BeerGlassStem(width: 50)
        }
    }
}
