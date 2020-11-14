// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct BandedShaft: View {
    var width: CGFloat = 100
    var strokeWidth: CGFloat = 40
    var color: Color
    var opacity: Double = 1
    
    init(color: Color, width: CGFloat = 50) {
        self.color = color
        self.width = width
    }
    
    var body: some View {
        VStack(spacing: 0) {
            band
            shaft
        }
    }
    
    var band: some View {
        Rectangle()
            .fill(color)
            .frame(width: width, height: strokeWidth)
    }
    
    var shaft: some View {
        Rectangle()
            .fill()
            .frame(width: width)
    }
}

struct BandedShaft_Previews: PreviewProvider {
    static var previews: some View {
        BandedShaft(color: .purple)
    }
}
