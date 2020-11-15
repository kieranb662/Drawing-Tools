// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct BrushStem<Fill: ShapeStyle, Stroke: ShapeStyle>: View {
    var width: CGFloat = 100
    private let standardWidth: CGFloat = 100
    private var scaleFactor: CGFloat {
        width != 0 ? width/standardWidth : 1
    }
    private let standardHeight: CGFloat = 150
    private let strokeStyle: StrokeStyle
    private let fill: Fill
    private let stroke: Stroke
    
    init(width: CGFloat = 90) where Fill == Color, Stroke == Color {
        self.width = width
        self.strokeStyle = StrokeStyle(lineWidth: 4, lineJoin: .round)
        self.fill = Color(white: 0.1)
        self.stroke = Color(white: 0.1)
    }
    
    init(width: CGFloat = 90,
         fill: Fill,
         stroke: Stroke,
         strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 4, lineJoin: .round))  {
        self.width = width
        self.strokeStyle = strokeStyle
        self.fill = fill
        self.stroke = stroke
    }
    
    var body: some View {
        BrushStemShape()
            .fill(fill)
            .overlay(
                BrushStemShape()
                    .strokeBorder(stroke, style: strokeStyle)
            )
            .frame(width: width, height: scaleFactor*standardHeight)
    }
}

extension BrushStem: DrawingToolComponent {
    var terminalWidth: CGFloat {
        width*0.4
    }
}

struct BrushStem_Previews: PreviewProvider {
    static let colors = [Color(white: 0.0), Color(white: 0.2), Color(white: 0.0), Color(white: 0.2)]
    static var previews: some View {
        HStack {
            BrushStem(fill: AngularGradient(gradient: Gradient(
                                                stops: [.init(color: Color(white: 0.0), location: 0),
                                                        .init(color: Color(white: 0.2), location: 0.7),
                                                        .init(color: Color(white: 0.0), location: 0.9),
                                                        .init(color: Color(white: 0.2), location: 1)]),
                                            center: UnitPoint(x: 0.5, y: -0.5),
                                            startAngle: .degrees(70),
                                            endAngle: .degrees(110)),
                      stroke: Color(white: 0.1))
            
            //            BrushStem()
            //            BrushStem(width: 200)
            //            BrushStem(width: 50)
        }
    }
}
