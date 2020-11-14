// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct FlashlightStem: View {
    var width: CGFloat = 100
    
    let standardHeight: CGFloat = 150
    let standardWidth: CGFloat = 100
    let stemStrokeStyle: StrokeStyle = StrokeStyle(lineWidth: 4, lineJoin: .round)
    
    init(width: CGFloat = 100) {
        self.width = width
    }
    
    var scaleFactor: CGFloat {
        width != 0 ? width/standardWidth : 1
    }
    
    var body: some View {
        FlashlightShape()
            .fill()
            .overlay(
                FlashlightShape()
                    .strokeBorder(style: stemStrokeStyle)
            )
            .frame(width: width, height: scaleFactor*standardHeight)
    }
}

extension FlashlightStem: MarkerStem {
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
