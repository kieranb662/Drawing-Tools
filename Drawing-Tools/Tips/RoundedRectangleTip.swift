// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct RoundedRectangleTip: View {
    var color: Color
    var width: CGFloat = 12
    let standardWidth: CGFloat = 12
    let standardHeight: CGFloat = 15
    let strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 7, lineJoin: .round)
    
    init(color: Color, width: CGFloat = 50) {
        self.color = color
        self.width = width
    }
    
    var scaleFactor: CGFloat {
        width != 0 ? width/standardWidth : 1
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
            RoundedRectangleTip(color: .orange)
            RoundedRectangleTip(color: .orange, width: 100)
            RoundedRectangleTip(color: .orange, width: 50)
        }
    }
}
