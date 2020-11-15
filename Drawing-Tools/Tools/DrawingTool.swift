// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

protocol DrawingToolComponent {
    var terminalWidth: CGFloat { get }
}

struct DrawingTool<Tip, Stem: DrawingToolComponent, Shaft>: View where Tip: View, Stem: View, Shaft: View {
    var tip: (Color, CGFloat) -> Tip
    var stem: (CGFloat) -> Stem
    var shaft: (Color, CGFloat) -> Shaft
    var color: Color = .black
    var opacity: Double = 1
    var width: CGFloat = 100
    var stemInset: CGFloat = 0
    var tipInset: CGFloat = 0
    
    init(
        tip: @escaping (Color, CGFloat) -> Tip,
        stem: @escaping (CGFloat) -> Stem,
        shaft: @escaping (Color, CGFloat) -> Shaft,
        color: Color = .black,
        opacity: Double = 1,
        width: CGFloat = 100,
        stemInset: CGFloat = 0,
        tipInset: CGFloat = 0
    ) {
        self.tip = tip
        self.stem = stem
        self.shaft = shaft
        self.color = color
        self.opacity = opacity
        self.width = width
        self.stemInset = stemInset
        self.tipInset = tipInset
    }
    
    var stemWidth: CGFloat {
        width-2*stemInset
    }
    
    var tipWidth: CGFloat {
        stem(stemWidth).terminalWidth - 2*tipInset
    }
    
    var body: some View {
        VStack(spacing: 0) {
            tip(color, tipWidth)
            stem(stemWidth)
            shaft(color, width)
        }
    }
}

extension DrawingTool {
    
    init(
        tip: @escaping (Color, CGFloat) -> Tip,
        stem: @escaping (CGFloat) -> Stem,
        shaft: Shaft,
        color: Color = .black,
        opacity: Double = 1,
        width: CGFloat = 100,
        stemInset: CGFloat = 0,
        tipInset: CGFloat = 0
    ) {
        self.tip = tip
        self.stem = stem
        self.shaft = { _,_ in shaft}
        self.color = color
        self.opacity = opacity
        self.width = width
        self.stemInset = stemInset
        self.tipInset = tipInset
    }
    
    
    init(
        tip: @escaping (Color, CGFloat) -> Tip,
        stem: Stem,
        shaft: Shaft,
        color: Color = .black,
        opacity: Double = 1,
        width: CGFloat = 100,
        stemInset: CGFloat = 0,
        tipInset: CGFloat = 0
    ) {
        self.tip = tip
        self.stem = { _ in stem}
        self.shaft = { _,_ in shaft}
        self.color = color
        self.opacity = opacity
        self.width = width
        self.stemInset = stemInset
        self.tipInset = tipInset
    }
    
    
    
}


struct DrawingTool_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.horizontal) {
            HStack {
                DrawingTool.pen(color: .blue, width: 75)
                DrawingTool.marker(color: .purple, width: 75)
                
                DrawingTool.chiselMarker(color: .yellow, width: 75)
                DrawingTool.roundMarker(color: .green, width: 75)
                DrawingTool.fineTipPen(color: .pink, width: 75)
                DrawingTool.graphitePencil(color: .gray, width: 75)
                
            }.frame(height: 600)
        }
    }
}
