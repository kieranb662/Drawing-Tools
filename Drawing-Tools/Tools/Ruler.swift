// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI
import Shapes 

struct RulerIcon: View {
    var length: CGFloat = 500
    var tickSpacing: CGFloat = 10
    var tickColor: Color = Color(white: 0.9)
    var majorTickLength: CGFloat = 30
    var tickBackgroundColor: Color = Color(white: 0.1)
    var nonTickBackgroundColor: Color = Color(white: 0.2)
    var rulerWidth: CGFloat = 80
    var cornerRadius: CGFloat = 5
    
    var body: some View {
        HStack(spacing: 0) {
            TickMarks(spacing: tickSpacing,
                      ticks: Int(length/tickSpacing),
                      isVertical: true)
                .stroke(tickColor)
                .frame(width: majorTickLength)
                .padding(.vertical, 6)
                .padding(.leading, 4)
                .padding(.trailing, 5)
                .background(
                    OmniRectangle(topLeft: .round(radius: cornerRadius),
                                  topRight: .square,
                                  bottomLeft: .round(radius: cornerRadius),
                                  bottomRight: .square)
                        .fill(tickBackgroundColor)
                )
            
            OmniRectangle(topLeft: .square,
                          topRight: .round(radius: cornerRadius),
                          bottomLeft: .square,
                          bottomRight: .round(radius: cornerRadius))
                .fill(nonTickBackgroundColor)
                .frame(width: rulerWidth - majorTickLength)
        }
        .frame(height: length)
        .clipped()
    }
}

struct Ruler: View {
    var length: CGFloat = 500
    var tickSpacing: CGFloat = 10
    var tickColor: Color = Color(white: 0.9)
    var majorTickLength: CGFloat = 30
    var tickBackgroundColor: Color = Color(white: 0.1)
    var nonTickBackgroundColor: Color = Color(white: 0.2)
    var rulerWidth: CGFloat = 80
    var cornerRadius: CGFloat = 5
    @State private var offset: CGSize = .zero
    @State private var dragState: CGSize = .zero
    @State private var angle: Angle = Angle(degrees: -45)
    @State private var rotationState: Angle = .zero
    
    var body: some View {
        RulerIcon(length: length,
                  tickSpacing: tickSpacing,
                  tickColor: tickColor,
                  majorTickLength: majorTickLength,
                  tickBackgroundColor: tickBackgroundColor,
                  nonTickBackgroundColor: nonTickBackgroundColor,
                  rulerWidth: rulerWidth,
                  cornerRadius: cornerRadius)
        .padding(.leading)
        .rotationEffect(angle + rotationState)
        .gesture(dragGesture)
        .offset(x: offset.width + dragState.width,
                y: offset.height + dragState.height)
        .simultaneousGesture(rotationGesture)
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged({ self.dragState = $0.translation })
            .onEnded({ (value) in
                self.offset.width += value.translation.width
                self.offset.height += value.translation.height
                self.dragState = .zero
            })
    }
    
    var rotationGesture: some Gesture {
        RotationGesture()
            .onChanged({ self.rotationState = $0 })
            .onEnded({ (angle) in
                self.rotationState = .zero
                self.angle += angle
            })
    }
}

struct Ruler_Previews: PreviewProvider {
    static var previews: some View {
        Ruler()
    }
}
