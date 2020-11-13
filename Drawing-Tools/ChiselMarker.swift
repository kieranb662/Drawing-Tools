// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct ChiselShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: h))
            path.addLine(to: CGPoint(x: 0, y: h/3))
            path.addLine(to: CGPoint(x: w, y: 0))
            path.addLine(to: CGPoint(x: w, y: h))
            path.closeSubpath()
        }
    }
}

struct ChiselStemShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: h))
            path.addCurve(to: CGPoint(x: w/4, y: h/2),
                          control1: CGPoint(x: 0, y: 2*h/3),
                          control2: CGPoint(x: w/4, y: 2*h/3))
            
            path.addLine(to: CGPoint(x: w/4, y: 0))
            path.addLine(to: CGPoint(x: 3*w/4, y: 0))
            path.addLine(to: CGPoint(x: 3*w/4, y: h/2))
            
            path.addCurve(to: CGPoint(x: w, y: h),
                          control1: CGPoint(x: 3*w/4, y: 2*h/3),
                          control2: CGPoint(x: w, y: 2*h/3))

            path.closeSubpath()
        }
    }
}

let ratio = 50/75
let minWidth = 30
let maxWidth = 50

struct ChiselStemShape2: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: h))
            path.addLine(to: CGPoint(x: 0, y: 4*h/5))
            
            path.addCurve(to: CGPoint(x: w/4, y: h/2),
                          control1: CGPoint(x: 0, y: 2*h/3),
                          control2: CGPoint(x: w/4, y: 2*h/3))
            
            path.addLine(to: CGPoint(x: w/4, y: 0))
            path.addLine(to: CGPoint(x: 3*w/4, y: 0))
            path.addLine(to: CGPoint(x: 3*w/4, y: h/2))
            
            path.addCurve(to: CGPoint(x: w, y: 4*h/5),
                          control1: CGPoint(x: 3*w/4, y: 2*h/3),
                          control2: CGPoint(x: w, y: 2*h/3))
            path.addLine(to: CGPoint(x: w, y: h))

            path.closeSubpath()
        }
    }
}

struct ChiselMarkerShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        
        return Path { path in
            
        }
    }
}

struct ChiselMarker: View {
    let tipStrokeStyle: StrokeStyle = StrokeStyle(lineWidth: 7, lineJoin: .round)
    
    var body: some View {
        HStack(spacing: 50) {
            
//            ChiselMarkerShape()
//                .stroke()
            
//            ChiselShape()
//                .stroke(style: tipStrokeStyle)
//                .frame(width: 100, height: 100)
            
            ChiselStemShape()
                .stroke(style: tipStrokeStyle)
                .frame(width: 100, height: 150)
            
            ChiselStemShape2()
                .stroke(style: tipStrokeStyle)
                .frame(width: 100, height: 150)
               
            
        }
    }
}

struct ChiselMarker_Previews: PreviewProvider {
    static var previews: some View {
        ChiselMarker()
    }
}
