// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//


import SwiftUI

struct CornerStyles {
    var topLeft: CornerStyle
    var topRight: CornerStyle
    var bottomLeft: CornerStyle
    var bottomRight: CornerStyle
    
    init(topLeft: CornerStyle, topRight: CornerStyle, bottomLeft: CornerStyle, bottomRight: CornerStyle) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
    
    init(_ corners: CornerSet = .all, style: CornerStyle) {
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

struct EdgeStyles {
    var leftCurvature: CGFloat
    var topCurvature: CGFloat
    var rightCurvature: CGFloat
    var bottomCurvature: CGFloat
    
    init(leftCurvature: CGFloat, topCurvature: CGFloat, rightCurvature: CGFloat, bottomCurvature: CGFloat) {
        self.leftCurvature = leftCurvature
        self.topCurvature = topCurvature
        self.rightCurvature = rightCurvature
        self.bottomCurvature = bottomCurvature
    }
    
    init(_ edges: UIRectEdge = .all, curvature: CGFloat) {
        self.leftCurvature   = edges.contains(.left)   ? curvature : 0
        self.topCurvature    = edges.contains(.top)    ? curvature : 0
        self.rightCurvature  = edges.contains(.right)  ? curvature : 0
        self.bottomCurvature = edges.contains(.bottom) ? curvature : 0
    }
    
    static func allFlat() -> EdgeStyles {
        EdgeStyles(leftCurvature: 0,
                   topCurvature: 0,
                   rightCurvature: 0,
                   bottomCurvature: 0)
    }
}

struct OmniRectangle: Shape {
    private var insetAmount: CGFloat = 0
    var cornerStyles: CornerStyles
    var edgeStyles: EdgeStyles
    
    init(corners: CornerStyles = .allSquare(), edges: EdgeStyles = .allFlat()) {
        self.cornerStyles = corners
        self.edgeStyles = edges
    }
    
    init(topLeft: CornerStyle, topRight: CornerStyle, bottomLeft: CornerStyle, bottomRight: CornerStyle) {
        self.cornerStyles = CornerStyles(topLeft: topLeft,
                                         topRight: topRight,
                                         bottomLeft: bottomLeft,
                                         bottomRight: bottomRight)
        self.edgeStyles = .allFlat()
    }
    
    init(leftEdgeCurvature: CGFloat, topEdgeCurvature: CGFloat, rightEdgeCurvature: CGFloat, bottomEdgeCurvature: CGFloat) {
        self.edgeStyles = EdgeStyles(leftCurvature: leftEdgeCurvature,
                                     topCurvature: topEdgeCurvature,
                                     rightCurvature: rightEdgeCurvature,
                                     bottomCurvature: bottomEdgeCurvature)
        
        self.cornerStyles = .allSquare()
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let insetRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
            let (width, height) = (insetRect.width, insetRect.height)
            let control = CGPoint(x: width/2, y: edgeStyles.topCurvature*height/2)
            
            cornerStyles.topRight.applyTopRight(&path, width, height)
            cornerStyles.bottomRight.applyBottomRight(&path, width, height, edgeStyles.rightCurvature)
            cornerStyles.bottomLeft.applyBottomLeft(&path, width, height, edgeStyles.bottomCurvature)
            cornerStyles.topLeft.applyTopLeft(&path, width,height, edgeStyles.leftCurvature)
            
            switch cornerStyles.topRight {
            case .round(let radius):
                path.addQuadCurve(to: CGPoint(x: width - radius, y: 0), control: control)
            case .cut(let depth):
                path.addQuadCurve(to: CGPoint(x: width - depth, y: 0), control: control)
            case .square:
                path.addQuadCurve(to: CGPoint(x: width, y: 0), control: control)
            }
            
            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension OmniRectangle: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

extension OmniRectangle {
    fileprivate func prepare(stroke: StrokeStyle, width: CGFloat = 100, height: CGFloat = 100) -> some View {
        ZStack {
            self
                .strokeBorder(Color.red, style: stroke)
        }
        .padding()
            .frame(width: width, height: height)
//            .border(Color.red)
    }
}

struct AnyCornerRectangle_Previews: PreviewProvider {
    static let roundThinStrokeStyle = StrokeStyle(lineWidth: 1, lineJoin: .round)
    static let roundThickStrokeStyle = StrokeStyle(lineWidth: 30, lineJoin: .round)
    static let miterThinStrokeStyle = StrokeStyle(lineWidth: 1, lineJoin: .miter)
    static let miterThickStrokeStyle = StrokeStyle(lineWidth: 30, lineJoin: .miter)
    static let bevelThinStrokeStyle = StrokeStyle(lineWidth: 1, lineJoin: .bevel)
    static let bevelThickStrokeStyle = StrokeStyle(lineWidth: 30, lineJoin: .bevel)
    
    static let squareCornersFlatEdges = OmniRectangle()
    static let roundCornersFlatEdges = OmniRectangle(corners: CornerStyles(style: .round(radius: 10)))
    static let cutCornersFlatEdges = OmniRectangle(corners: CornerStyles(style: .cut(depth: 10)))
    
    
    static let fullPositiveCurvature = EdgeStyles(curvature: 1)
    static let halfPositiveCurvature = EdgeStyles(curvature: 0.5)
    
    static let fullNegativeCurvature = EdgeStyles(curvature: -1)
    static let halfNegativeCurvature = EdgeStyles(curvature: -0.5)
    
    static func makeRow(_ omniShape: OmniRectangle) -> some View {
        HStack(spacing: 30) {
            omniShape
                .fill(Color.purple)
                .padding()
                .frame(width: 100, height: 100)
            omniShape.prepare(stroke: roundThinStrokeStyle)
            omniShape.prepare(stroke: roundThickStrokeStyle)
            omniShape.prepare(stroke: miterThinStrokeStyle)
            omniShape.prepare(stroke: miterThickStrokeStyle)
            omniShape.prepare(stroke: bevelThinStrokeStyle)
            omniShape.prepare(stroke: bevelThickStrokeStyle)
        }
    }
    
    static var previews: some View {
        VStack(spacing: 40) {
            makeRow(squareCornersFlatEdges)
            makeRow(roundCornersFlatEdges)
            makeRow(cutCornersFlatEdges)
            
            makeRow(OmniRectangle(topLeft: .square,
                                  topRight: .round(radius: 10),
                                  bottomLeft: .cut(depth: 15),
                                  bottomRight: .round(radius: 5)))
            
            makeRow(OmniRectangle(edges: fullPositiveCurvature))
            makeRow(OmniRectangle(edges: halfPositiveCurvature))
            makeRow(OmniRectangle(edges: halfNegativeCurvature))
            makeRow(OmniRectangle(edges: fullNegativeCurvature))
            
            
        }
    }
}
