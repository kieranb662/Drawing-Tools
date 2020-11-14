// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct MarkerView<Tip: InsettableShape, Stem: InsettableShape>: View {
    var tipShape: Tip
    var tipSize: CGSize
    var stemShape: Stem
    var stemHeight: CGFloat = 150
    var markerWidth: CGFloat = 100
    var strokeWidth: CGFloat = 40
    var maxHeight: CGFloat = 600
    var color: Color
    var opacity: Double = 1
    let tipStrokeStyle: StrokeStyle = StrokeStyle(lineWidth: 7, lineJoin: .round)
    let stemStrokeStyle: StrokeStyle = StrokeStyle(lineWidth: 4, lineJoin: .round)
    
    var body: some View {
        VStack(spacing: 0) {
            tip
            stem
            reservoir
            shaft
        }
        .frame(maxHeight: maxHeight)
    }
    
    var tip: some View {
        tipShape
            .fill(color)
            .overlay(
                tipShape
                    .strokeBorder(color, style: tipStrokeStyle)
            )
            .frame(width: tipSize.width, height: tipSize.height)
    }
    
    var stem: some View {
        stemShape
            .fill()
            .overlay(
                stemShape
                    .strokeBorder(style: stemStrokeStyle)
            )
            .frame(width: markerWidth, height: stemHeight)
    }
    
    var reservoir: some View {
        Rectangle()
            .fill(color)
            .frame(width: markerWidth, height: strokeWidth)
    }
    
    var shaft: some View {
        Rectangle()
            .fill()
            .frame(width: markerWidth)
    }
}

struct MarkerExamples: View {
    var body: some View {
        HStack {
            MarkerView(tipShape: ChiselShape(),
                       tipSize: CGSize(width: 50, height: 50),
                       stemShape: FlashlightShape(),
                       strokeWidth: 60,
                       color: .yellow)
            
//            MarkerView(tipShape: ChiselShape(),
//                       tipSize: CGSize(width: 50, height: 50),
//                       stemShape: BeerGlassShape(),
//                       color: .red)
            
            MarkerView(tipShape: Triangle(),
                       tipSize: CGSize(width: 35, height: 50),
                       stemShape: BrushStem(),
                       strokeWidth: 30,
                       color: .blue)
        }
    }
}

struct MarkerView_Previews: PreviewProvider {
    static var previews: some View {
       MarkerExamples()
    }
}
