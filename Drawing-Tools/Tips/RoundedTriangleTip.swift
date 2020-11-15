// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct RoundedTriangleTip: View {
    var color: Color
    var width: CGFloat = 35
    private let standardWidth: CGFloat = 35
    private let standardHeight: CGFloat = 50
    private var scaleFactor: CGFloat {
        width != 0 ? width/standardWidth : 1
    }
    private let strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 7, lineJoin: .round)
    
    init(color: Color, width: CGFloat = 50) {
        self.color = color
        self.width = width
    }

    var body: some View {
        Triangle()
            .fill(color)
            .overlay(
                Triangle()
                    .strokeBorder(color, style: strokeStyle)
            )
            .frame(width: width, height: scaleFactor*standardHeight)
    }
}

struct RoundedTriangleTip_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            RoundedTriangleTip(color: .red)
            RoundedTriangleTip(color: .red, width: 100)
            RoundedTriangleTip(color: .red, width: 17)
        }
    }
}
