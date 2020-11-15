// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI
import Shapes

struct FineTip: View {
    var color: Color
    var width: CGFloat = 12
    private let standardWidth: CGFloat = 12
    private var scaleFactor: CGFloat {
        width != 0 ? width/standardWidth : 1
    }
    private let standardHeight: CGFloat = 15
    private let strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 7, lineJoin: .round)
    
    init(color: Color, width: CGFloat = 50) {
        self.color = color
        self.width = width
    }
    
    var body: some View {
        OmniRectangle(topLeft: .round(radius: 2),
                      topRight: .round(radius: 2),
                      bottomLeft: .square,
                      bottomRight: .square)
            .fill(color)
            .frame(width: width, height: scaleFactor*standardHeight)
    }
}

struct RoundedRectangleTip_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            FineTip(color: .orange)
            FineTip(color: .orange, width: 100)
            FineTip(color: .orange, width: 50)
        }
    }
}
