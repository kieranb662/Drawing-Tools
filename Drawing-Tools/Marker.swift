// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct Marker<Tip, Stem, Shaft>: View where Tip: View, Stem: View, Shaft: View {
    var tip: (Color) -> Tip
    var stem: (Color) -> Stem
    var shaft: (Color) -> Shaft
    @State var color: Color = .black
    @State var opacity: Double = 1
    
    init(tip: @escaping (Color) -> Tip,
         stem: @escaping (Color) -> Stem,
         shaft: @escaping (Color) -> Shaft,
         color: Color = .black,
         opacity: Double = 1) {
        self.tip = tip
        self.stem = stem
        self.shaft = shaft
        self.color = color
        self.opacity = opacity
    }
    
    var body: some View {
        VStack(spacing: 0) {
            tip(color)
            stem(color)
            shaft(color)
        }
    }
}

extension Marker {
    
    init(tip: Tip, stem: Stem, shaft: Shaft, color: Color = .black, opacity: Double = 1) {
        self.tip = { _ in tip }
        self.stem = { _ in stem }
        self.shaft = { _ in shaft }
        self.color = color
        self.opacity = opacity
    }
}

extension Marker where Tip: InsettableShape {
    
    
    
    
}

//
//struct Marker_Previews: PreviewProvider {
//    static var previews: some View {
//
//    }
//}
