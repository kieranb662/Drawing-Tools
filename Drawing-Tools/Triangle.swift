// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

public struct Triangle: Shape {
    var leftEdgeCurvature: CGFloat
    var rightEdgeCurvature: CGFloat
    var bottomEdgeCurvature: CGFloat
    
    init(leftEdgeCurvature: CGFloat = 0,
         rightEdgeCurvature: CGFloat = 0,
         bottomEdgeCurvature: CGFloat = 0) {
        self.leftEdgeCurvature = leftEdgeCurvature
        self.rightEdgeCurvature = rightEdgeCurvature
        self.bottomEdgeCurvature = bottomEdgeCurvature
    }
    
    private var insetAmount: CGFloat = 0
    
    public func path(in rect: CGRect) -> Path {
        let insetRect: CGRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        let w = insetRect.width
        let h = insetRect.height
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: h))
            
            path.addQuadCurve(to: CGPoint(x: w/2, y: 0),
                              control: CGPoint(x: w*leftEdgeCurvature/4 + w/4, y: h/2))
            
            path.addQuadCurve(to: CGPoint(x: w, y: h),
                              control: CGPoint(x: 3*w/4 - w*rightEdgeCurvature/4, y: h/2))
            
            path.addQuadCurve(to: CGPoint(x: 0, y: h),
                              control: CGPoint(x: w/2, y: h - h*bottomEdgeCurvature/4))
            
            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension Triangle: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

extension Triangle {
    
    init(curvature: CGFloat = 0) {
        self.leftEdgeCurvature = curvature
        self.rightEdgeCurvature = curvature
        self.bottomEdgeCurvature = curvature
    }
    
}
