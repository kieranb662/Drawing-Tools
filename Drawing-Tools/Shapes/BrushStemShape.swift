// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct BrushStemShape: Shape {
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let insetRect: CGRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        let w = insetRect.width
        let h = insetRect.height
        
        return Path { path in
            path.move(to:    CGPoint(x:       0, y:       h))
            path.addLine(to: CGPoint(x: 0.1*w/5, y: 13*h/16))
            path.addLine(to: CGPoint(x: 1.5*w/5, y:       0))
            path.addLine(to: CGPoint(x: 3.5*w/5, y:       0))
            path.addLine(to: CGPoint(x: 4.9*w/5, y: 13*h/16))
            path.addLine(to: CGPoint(x:       w, y:       h))
            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension BrushStemShape: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}
