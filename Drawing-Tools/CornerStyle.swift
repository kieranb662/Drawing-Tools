// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct Corner {
    var value: CGFloat
    var style: Style
    
    enum Style: String, CaseIterable, Identifiable {
        case round
        case cut
        case square
        
        var id: String { rawValue }
    }
    
    static func round(radius: CGFloat) -> Corner {
        Corner(value: radius, style: .round)
    }
    
    static func cut(depth: CGFloat) -> Corner {
        Corner(value: depth, style: .cut)
    }
    
    static let square = Corner(value: .zero, style: .square)
    
    var cornerStyle: CornerStyle {
        get {
            switch style {
            case .round:  return .round(radius: value)
            case .cut:    return .cut(depth: value)
            case .square: return .square
            }
        }
        set {
            switch newValue {
            case .round(radius: let radius):
                self.style = .round
                self.value = radius
            case .cut(depth: let depth):
                self.style = .cut
                self.value = depth
            case .square:
                self.value = .zero
                self.style = .square
            }
        }
    }
}

extension Corner: CustomStringConvertible {
    var description: String {
        cornerStyle.description
    }
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
            path.addQuadCurve(to: CGPoint(x: width, y: height-checkMin(depth)),
                              control: CGPoint(x: width - width*curvature/2, y: height/2))
            path.addLine(to: CGPoint(x: width-checkMin(depth), y: height))
        case .square:
            path.addQuadCurve(to: CGPoint(x: width, y: height),
                              control: CGPoint(x: width - width*curvature/2, y: height/2))
        }
    }
    
    func applyBottomLeft(_ path: inout Path, _ width: CGFloat, _ height: CGFloat, _ curvature: CGFloat) -> Void {
        let checkMin: (CGFloat) -> CGFloat = { min(min($0, height/2), width/2) }
        switch self {
        case .round(radius: let radius):
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
            path.addQuadCurve(to: CGPoint(x: checkMin(depth), y: height),
                              control: CGPoint(x: width/2, y: height - height*curvature/2))
            path.addLine(to: CGPoint(x: 0, y: height-checkMin(depth)))
        case .square:
            path.addQuadCurve(to: CGPoint(x: 0, y: height),
                              control: CGPoint(x: width/2, y: height - height*curvature/2))
        }
    }
    
    func applyTopLeft(_ path: inout Path, _ width: CGFloat, _ height: CGFloat, _ curvature: CGFloat) -> Void {
        let checkMin: (CGFloat) -> CGFloat = { min(min($0, height/2), width/2) }
        switch self {
        case .round(radius: let radius):
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
            path.addQuadCurve(to: CGPoint(x: 0, y: checkMin(depth)),
                              control: CGPoint(x: width*curvature/2, y: height/2))
            
            
            path.addLine(to: CGPoint(x: checkMin(depth), y: 0))
        case .square:
            path.addQuadCurve(to: CGPoint(x: 0, y: 0),
                              control: CGPoint(x: width*curvature/2, y: height/2))
            
        }
    }
}


extension CornerStyle: CustomStringConvertible {
    
    static let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.maximumFractionDigits = 3
        
        return f
    }()
    
    var description: String {
        switch self {
        case .round(radius: let radius):
            return "radius: \(Self.formatter.string(from: radius as NSNumber) ?? "")"
        case .cut(depth: let depth):
            return "depth: \(Self.formatter.string(from: depth as NSNumber) ?? "")"
        case .square:
            return "square"
        }
    }
}

struct CornerStyles {
    var topLeft: Corner
    var topRight: Corner
    var bottomLeft: Corner
    var bottomRight: Corner
    
    init(topLeft: Corner, topRight: Corner, bottomLeft: Corner, bottomRight: Corner) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
    
    init(_ corners: UIRectCorner = .allCorners, style: Corner) {
        self.topLeft     = corners.contains(.topLeft)     ? style : .square
        self.bottomLeft  = corners.contains(.bottomLeft)  ? style : .square
        self.topRight    = corners.contains(.topRight)    ? style : .square
        self.bottomRight = corners.contains(.bottomRight) ? style : .square
    }
    
    static func allSquare() -> CornerStyles {
        CornerStyles(topLeft: .square,
                     topRight: .square,
                     bottomLeft: .square,
                     bottomRight: .square)
    }
}

extension CornerStyles: CustomStringConvertible {
    
    var description: String {
        """
        \(topLeft.description)
        \(topRight.description)
        \(bottomLeft.description)
        \(bottomRight)
        """
    }
    
}
