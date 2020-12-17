// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct ChiselTip: View {
    var color: Color
    var width: CGFloat = 50
    private let standardWidth: CGFloat = 50
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
        ZStack {
            ChiselShape()
                .stroke(color, style: strokeStyle)
                .frame(width: width-3, height: scaleFactor*(standardHeight-3))
            ChiselShape()
                .fill(color)
                .frame(width: width-3, height: scaleFactor*(standardHeight-3))
            
        }.padding(3)
    }
}

struct ChiselTip_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ChiselTip(color: .yellow)
            ChiselTip(color: .yellow, width: 200)
            ChiselTip(color: .yellow, width: 25)
        }
    }
}
