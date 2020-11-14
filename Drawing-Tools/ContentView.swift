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
            HStack {
                Triangle(curvature: 0.5)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Triangle(leftEdgeCurvature: -1, rightEdgeCurvature: -1, bottomEdgeCurvature: 0)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            HStack {
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
