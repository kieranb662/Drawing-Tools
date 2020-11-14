// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct MoleskinMarker: View {
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                OmniRectangle(topLeft: .round(radius: 2),
                              topRight: .round(radius: 2),
                              bottomLeft: .square,
                              bottomRight: .square)
                    .fill(Color.purple)
                    .frame(width: 12, height: 15)
                TieredStem()
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.purple)
                    .frame(width: 100)
            }.frame(maxHeight: 600)
        }
    }
}

struct MoleskinMarker_Previews: PreviewProvider {
    static var previews: some View {
        MoleskinMarker()
    }
}
