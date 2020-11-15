// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI
import Shapes 

struct BulletTip: View {
    var color: Color
    var width: CGFloat = 50
    private let standardWidth: CGFloat = 40
    private let standardHeight: CGFloat = 70
    private var scaleFactor: CGFloat {
        width != 0 ? width/standardWidth : 1
    }
    
    init(color: Color, width: CGFloat = 50) {
        self.color = color
        self.width = width
    }

    var body: some View {
        Triangle.bulletTip()
            .fill(color)
            .frame(width: width, height: scaleFactor*standardHeight)
    }
}

struct ButtelTip_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            BulletTip(color: .green)
            BulletTip(color: .green, width: 200)
            BulletTip(color: .green, width: 25)
        }
    }
}
