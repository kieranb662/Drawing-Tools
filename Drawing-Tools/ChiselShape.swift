// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct ChiselShape: Shape {
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let insetRect: CGRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        let w = insetRect.width
        let h = insetRect.height
        
        return Path { path in
            path.move(to:    CGPoint(x: 0, y:   h))
            path.addLine(to: CGPoint(x: 0, y: h/3))
            path.addLine(to: CGPoint(x: w, y:   0))
            path.addLine(to: CGPoint(x: w, y:   h))
            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension ChiselShape: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}
