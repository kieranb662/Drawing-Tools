// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount: CGFloat = 0
    var baseRatio: CGFloat
    var curvature: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let ratio = max(min(baseRatio, 1), 0)
        let insetRect: CGRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        let w = insetRect.width
        let h = insetRect.height
        let d = (w-w*ratio)/2
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: h))
            path.addQuadCurve(to: CGPoint(x: d, y: 0),
                              control: CGPoint(x: (w/2 - d/2)*curvature + d/2, y: h/2))
            path.addLine(to: CGPoint(x: w-d, y: 0))
            path.addQuadCurve(to: CGPoint(x: w, y: h),
                              control:  CGPoint(x: (d/2 - w/2)*curvature + w - d/2, y: h/2))
            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension Trapezoid: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

struct TrapezoidExample: View {
    var body: some View {
        HStack(spacing: 50) {
            VStack(spacing: 10) {
                Trapezoid(baseRatio: 0.6, curvature: 0.4)
                    .fill()
                    .frame(width: 75, height: 90)
                    .border(Color.red)
                
                Trapezoid(baseRatio: 0.8, curvature: 0)
                    .fill()
                    .frame(width: 75, height: 125)
                    .border(Color.red)
                
                Trapezoid(baseRatio: 0.8, curvature: -0.5)
                    .fill()
                    .frame(width: 75, height: 125)
                    .border(Color.red)
            }
            
            VStack(spacing: 10) {
                Trapezoid(baseRatio: 0.8)
                    .fill()
                    .frame(width: 125, height: 75)
                    .border(Color.red)
                
                Trapezoid(baseRatio: 0.8, curvature: 0)
                    .fill()
                    .frame(width: 125, height: 75)
                    .border(Color.red)
                
                Trapezoid(baseRatio: 0.8, curvature: -0.5)
                    .fill()
                    .frame(width: 125, height: 75)
                    .border(Color.red)
            }
            .frame(maxHeight: 600)
        }
    }
}

struct TrapezoidExample_Previews: PreviewProvider {
    static var previews: some View {
        TrapezoidExample()
    }
}
