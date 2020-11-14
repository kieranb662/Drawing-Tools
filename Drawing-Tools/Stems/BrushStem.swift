// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct BrushStem: View {
    var width: CGFloat = 100
    let standardHeight: CGFloat = 150
    let standardWidth: CGFloat = 100
    let stemStrokeStyle: StrokeStyle = StrokeStyle(lineWidth: 4, lineJoin: .round)
    
    init(width: CGFloat = 90) {
        self.width = width
    }
    
    var scaleFactor: CGFloat {
        width != 0 ? width/standardWidth : 1
    }
    
    var body: some View {
        BrushStemShape()
            .fill()
            .overlay(
                BrushStemShape()
                    .strokeBorder(style: stemStrokeStyle)
            )
            .frame(width: width, height: scaleFactor*standardHeight)
    }
}

extension BrushStem: MarkerStem {
    var terminalWidth: CGFloat {
        width*0.4
    }
}

struct BrushStem_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            BrushStem()
            BrushStem(width: 200)
            BrushStem(width: 50)
        }
    }
}
