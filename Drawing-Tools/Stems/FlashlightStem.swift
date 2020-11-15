// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI
import Shapes

struct FlashlightStem: View {
    var width: CGFloat = 100
    private let standardWidth: CGFloat = 100
    private var scaleFactor: CGFloat {
        width != 0 ? width/standardWidth : 1
    }
    private let standardHeight: CGFloat = 150
    private let strokeStyle: StrokeStyle
    private let color: Color
    
    init(width: CGFloat = 100) {
        self.width = width
        self.strokeStyle = StrokeStyle(lineWidth: 4, lineJoin: .round)
        self.color = Color(white: 0.1)
    }
    
    init(width: CGFloat = 100,
         color: Color = Color(white: 0.1),
         strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 4, lineJoin: .round)) {
        self.width = width
        self.strokeStyle = strokeStyle
        self.color = color
    }
    
    var body: some View {
        FlashlightShape()
            .fill(color)
            .overlay(
                FlashlightShape()
                    .strokeBorder(color, style: strokeStyle)
            )
            .frame(width: width, height: scaleFactor*standardHeight)
    }
}

extension FlashlightStem: DrawingToolComponent {
    var terminalWidth: CGFloat {
        0.6*width
    }
}

struct FlashlightStem_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            FlashlightStem()
            FlashlightStem(width: 200)
            FlashlightStem(width: 50)
        }
    }
}
