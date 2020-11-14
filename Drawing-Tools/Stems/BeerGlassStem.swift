// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct BeerGlassStem: View {
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
        BeerGlassShape()
            .fill()
            .overlay(
                BeerGlassShape()
                    .strokeBorder(style: stemStrokeStyle)
            )
            .frame(width: width, height: scaleFactor*standardHeight)
    }
}

extension BeerGlassStem: MarkerStem {
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
