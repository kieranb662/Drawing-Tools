// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct CornerSet: OptionSet {
    var rawValue: Int
    
    init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    static let topLeft     = CornerSet(rawValue: 1 << 0)
    static let topRight    = CornerSet(rawValue: 1 << 1)
    static let bottomLeft  = CornerSet(rawValue: 1 << 2)
    static let bottomRight = CornerSet(rawValue: 1 << 3)
    
    static let tops: CornerSet = [.topLeft, .topRight]
    static let bottoms: CornerSet = [.bottomLeft, .bottomRight]
    static let lefts: CornerSet = [.topLeft, .bottomLeft]
    static let rights: CornerSet = [.topRight, .bottomRight]
    
    static let all: CornerSet = [.topLeft, .topRight, .bottomLeft, .bottomRight]
}

enum CornerStyle {
    case round(radius: CGFloat)
    case cut(depth: CGFloat)
    case square
}

extension CornerStyle {
    func applyTopRight(_ path: inout Path, _ width: CGFloat, _ height: CGFloat) -> Void  {
        let checkMin: (CGFloat) -> CGFloat = { min(min($0, height/2), width/2) }
        switch self {
        case .round(radius: let radius):
            path.move(to: CGPoint(x: width - checkMin(radius), y: 0))
            path.addArc(
                center: CGPoint(x: width - checkMin(radius), y: checkMin(radius)),
                radius: checkMin(radius),
                startAngle: Angle(radians: -.pi/2),
                endAngle:  .zero,
                clockwise: false
            )
        case .cut(depth: let depth):
            path.move(to: CGPoint(x: width-checkMin(depth), y: 0))
            path.addLine(to: CGPoint(x: width, y: checkMin(depth)))
        case .square:
            path.move(to: CGPoint(x: width, y: 0))
        }
    }
    
    func applyBottomRight(_ path: inout Path, _ width: CGFloat, _ height: CGFloat, _ curvature: CGFloat) -> Void {
        let checkMin: (CGFloat) -> CGFloat = { min(min($0, height/2), width/2) }
        switch self {
        case .round(radius: let radius):
            //            path.addLine(to: CGPoint(x: width, y: height - checkMin(radius)))
            path.addQuadCurve(to: CGPoint(x: width, y: height - checkMin(radius)),
                              control: CGPoint(x: width - width*curvature/2, y: height/2))
            path.addArc(
                center: CGPoint(x: width - checkMin(radius) , y: height - checkMin(radius)),
                radius: checkMin(radius),
                startAngle: .zero,
                endAngle: Angle(radians: .pi/2),
                clockwise: false
            )
        case .cut(depth: let depth):
            //            path.addLine(to: CGPoint(x: width, y: height-checkMin(depth)))
            path.addQuadCurve(to: CGPoint(x: width, y: height-checkMin(depth)),
                              control: CGPoint(x: width - width*curvature/2, y: height/2))
            
            
            path.addLine(to: CGPoint(x: width-checkMin(depth), y: height))
        case .square:
            //            path.addLine(to: CGPoint(x: width, y: height))
            path.addQuadCurve(to: CGPoint(x: width, y: height),
                              control: CGPoint(x: width - width*curvature/2, y: height/2))
        }
    }
    
    func applyBottomLeft(_ path: inout Path, _ width: CGFloat, _ height: CGFloat, _ curvature: CGFloat) -> Void {
        let checkMin: (CGFloat) -> CGFloat = { min(min($0, height/2), width/2) }
        switch self {
        case .round(radius: let radius):
            //            path.addLine(to: CGPoint(x: checkMin(radius), y: height))
            
            path.addQuadCurve(to: CGPoint(x: checkMin(radius), y: height),
                              control: CGPoint(x: width/2, y: height - height*curvature/2))
            
            path.addArc(
                center: CGPoint(x: checkMin(radius), y: height - checkMin(radius)),
                radius: checkMin(radius),
                startAngle: Angle(radians: .pi/2),
                endAngle:  Angle(radians: .pi),
                clockwise: false
            )
        case .cut(depth: let depth):
            //            path.addLine(to: CGPoint(x: checkMin(depth), y: height))
            path.addQuadCurve(to: CGPoint(x: checkMin(depth), y: height),
                              control: CGPoint(x: width/2, y: height - height*curvature/2))
            path.addLine(to: CGPoint(x: 0, y: height-checkMin(depth)))
        case .square:
            path.addQuadCurve(to: CGPoint(x: 0, y: height),
                              control: CGPoint(x: width/2, y: height - height*curvature/2))
        //            path.addLine(to: CGPoint(x: 0, y: height))
        }
    }
    
    func applyTopLeft(_ path: inout Path, _ width: CGFloat, _ height: CGFloat, _ curvature: CGFloat) -> Void {
        let checkMin: (CGFloat) -> CGFloat = { min(min($0, height/2), width/2) }
        switch self {
        case .round(radius: let radius):
            //            path.addLine(to: CGPoint(x: 0, y: checkMin(radius)))
            path.addQuadCurve(to: CGPoint(x: 0, y: checkMin(radius)),
                              control: CGPoint(x: width*curvature/2, y: height/2))
            
            path.addArc(
                center: CGPoint(x: checkMin(radius), y: checkMin(radius)),
                radius: checkMin(radius),
                startAngle: Angle(radians: .pi),
                endAngle: Angle(radians: 3*Double.pi/2),
                clockwise: false
            )
        case .cut(depth: let depth):
            //            path.addLine(to: CGPoint(x: 0, y: checkMin(depth)))
            
            path.addQuadCurve(to: CGPoint(x: 0, y: checkMin(depth)),
                              control: CGPoint(x: width*curvature/2, y: height/2))
            
            
            path.addLine(to: CGPoint(x: checkMin(depth), y: 0))
        case .square:
            //            path.addLine(to: .zero)
            path.addQuadCurve(to: CGPoint(x: 0, y: 0),
                              control: CGPoint(x: width*curvature/2, y: height/2))
            
        }
    }
}
