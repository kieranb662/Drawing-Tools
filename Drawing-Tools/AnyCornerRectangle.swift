// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//


import SwiftUI

struct AnyCornerRectangle: Shape {
    private var insetAmount: CGFloat = 0
    var topLeft: CornerStyle
    var topRight: CornerStyle
    var bottomLeft: CornerStyle
    var bottomRight: CornerStyle
    
    init(topLeft: CornerStyle,
         topRight: CornerStyle,
         bottomLeft: CornerStyle,
         bottomRight: CornerStyle) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let insetRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
            let (width, height) = (insetRect.width, insetRect.height)
            topRight.applyTopRight(&path, width, height)
            bottomRight.applyBottomRight(&path, width, height)
            bottomLeft.applyBottomLeft(&path, width,height)
            topLeft.applyTopLeft(&path, width,height)
            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension AnyCornerRectangle: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
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
    
    func applyBottomRight(_ path: inout Path, _ width: CGFloat, _ height: CGFloat) -> Void {
        let checkMin: (CGFloat) -> CGFloat = { min(min($0, height/2), width/2) }
        switch self {
        case .round(radius: let radius):
            path.addLine(to: CGPoint(x: width, y: height - checkMin(radius)))
            path.addArc(
                center: CGPoint(x: width - checkMin(radius) , y: height - checkMin(radius)),
                radius: checkMin(radius),
                startAngle: .zero,
                endAngle: Angle(radians: .pi/2),
                clockwise: false
            )
        case .cut(depth: let depth):
            path.addLine(to: CGPoint(x: width, y: height-checkMin(depth)))
            path.addLine(to: CGPoint(x: width-checkMin(depth), y: height))
        case .square:
            path.addLine(to: CGPoint(x: width, y: height))
        }
    }
    
    func applyBottomLeft(_ path: inout Path, _ width: CGFloat, _ height: CGFloat) -> Void {
        let checkMin: (CGFloat) -> CGFloat = { min(min($0, height/2), width/2) }
        switch self {
        case .round(radius: let radius):
            path.addLine(to: CGPoint(x: checkMin(radius), y: height))
            path.addArc(
                center: CGPoint(x: checkMin(radius), y: height - checkMin(radius)),
                radius: checkMin(radius),
                startAngle: Angle(radians: .pi/2),
                endAngle:  Angle(radians: .pi),
                clockwise: false
            )
        case .cut(depth: let depth):
            path.addLine(to: CGPoint(x: checkMin(depth), y: height))
            path.addLine(to: CGPoint(x: 0, y: height-checkMin(depth)))
        case .square:
            path.addLine(to: CGPoint(x: 0, y: height))
        }
    }
    
    func applyTopLeft(_ path: inout Path, _ width: CGFloat, _ height: CGFloat) -> Void {
        let checkMin: (CGFloat) -> CGFloat = { min(min($0, height/2), width/2) }
        switch self {
        case .round(radius: let radius):
            path.addLine(to: CGPoint(x: 0, y: checkMin(radius)))
            path.addArc(
                center: CGPoint(x: checkMin(radius), y: checkMin(radius)),
                radius: checkMin(radius),
                startAngle: Angle(radians: .pi),
                endAngle: Angle(radians: 3*Double.pi/2),
                clockwise: false
            )
        case .cut(depth: let depth):
            path.addLine(to: CGPoint(x: 0, y: checkMin(depth)))
            path.addLine(to: CGPoint(x: checkMin(depth), y: 0))
        case .square:
            path.addLine(to: .zero)
        }
    }
}

struct AnyCornerRectangle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            HStack {
                AnyCornerRectangle(topLeft: .round(radius: 10),
                                   topRight: .round(radius: 10),
                                   bottomLeft: .round(radius: 10),
                                   bottomRight: .round(radius: 10))
                    .stroke(lineWidth: 10)
                    .frame(width: 100, height: 100)
                    .border(Color.red)
                AnyCornerRectangle(topLeft: .round(radius: 10),
                                   topRight: .round(radius: 10),
                                   bottomLeft: .round(radius: 10),
                                   bottomRight: .round(radius: 10))
                    .strokeBorder(lineWidth: 10)
                    .frame(width: 100, height: 100)
                    .border(Color.red)
            }
            
            HStack {
                AnyCornerRectangle(topLeft: .round(radius: 10),
                                   topRight: .cut(depth: 20),
                                   bottomLeft: .square,
                                   bottomRight: .round(radius: 10))
                    .stroke(lineWidth: 10)
                    .frame(width: 100, height: 100)
                    .border(Color.red)
                AnyCornerRectangle(topLeft: .round(radius: 10),
                                   topRight: .cut(depth: 20),
                                   bottomLeft: .square,
                                   bottomRight: .round(radius: 10))
                    .strokeBorder(lineWidth: 10)
                    .frame(width: 100, height: 100)
                    .border(Color.red)
            }
        }
    }
}
