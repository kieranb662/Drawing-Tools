// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            HStack(alignment: .top) {
                BulletMarkerView()
                GemTipMarker()
                MoleskinMarker()
                MarkerExamples()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
