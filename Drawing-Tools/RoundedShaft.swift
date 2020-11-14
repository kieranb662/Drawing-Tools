// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct RoundedShaft: View {
    var color: Color
    var shaftSize: CGSize = CGSize(width: 110, height: 300)
    var shaftCornerRadius: CGFloat = 5
    
    var body: some View {
        RoundedRectangle(cornerRadius: shaftCornerRadius)
            .fill(color)
            .frame(width: shaftSize.width, height: shaftSize.height)
    }
}

struct RoundedShaft_Previews: PreviewProvider {
    static var previews: some View {
        RoundedShaft(color: .blue)
    }
}
