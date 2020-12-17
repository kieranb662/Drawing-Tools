// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

// MARK: - Apple Inspired tools

let stemGradient = AngularGradient(
    gradient: Gradient(
        stops: [
                .init(color: Color(white: 0.2), location: 0),
            .init(color: Color(white: 0.0), location: 0.1),
                .init(color: Color(white: 0.2), location: 0.3),
            .init(color: Color(white: 0.0), location: 1),]),
    center: UnitPoint(x: 0.5, y: -0.5),
    startAngle: .degrees(55),
    endAngle: .degrees(110))

let shaftGradient = LinearGradient(
    gradient: Gradient(
        stops: [.init(color: Color(white: 0.0), location: 0),
                .init(color: Color(white: 0.1), location: 0.7),
                .init(color: Color(white: 0.15), location: 0.9),
                .init(color: Color(white: 0.2), location: 1)]),
    startPoint: .leading,
    endPoint: .trailing)

extension DrawingTool where Shaft == BandedShaft<LinearGradient> {
    
    static func pen(color: Color,
                    opacity: Double = 1,
                    width: CGFloat = 100,
                    bandThickness: CGFloat = 40) -> DrawingTool where Tip == RoundedTriangleTip, Stem == BrushStem<AngularGradient, Color> {
        
        let stem = BrushStem(
            width: width,
            fill: stemGradient,
            stroke: Color(white: 0.1),
            strokeStyle: StrokeStyle(lineWidth: 2, lineJoin: .round))
        
        let shaft = BandedShaft(
            color: color,
            opacity: opacity,
            width: width,
            bandThickness: bandThickness,
            fill: shaftGradient)
        
        return DrawingTool(
            tip: RoundedTriangleTip.init,
            stem: stem,
            shaft: shaft,
            color: color,
            opacity: opacity,
            width: width,
            stemInset: 0,
            tipInset: 0)
    }
    
    static func marker(color: Color,
                       opacity: Double = 1,
                       width: CGFloat = 100,
                       bandThickness: CGFloat = 40) -> DrawingTool where Tip == ChiselTip, Stem == BeerGlassStem<LinearGradient, Color>  {
        
        let stem = BeerGlassStem(width: width,
                                 fill: shaftGradient,
                                 stroke: Color(white: 0.1),
                                 strokeStyle: StrokeStyle(lineWidth: 2, lineJoin: .round))
        
        let shaft = BandedShaft(color: color,
                                opacity: opacity,
                                width: width,
                                bandThickness: bandThickness,
                                fill: shaftGradient)
        
        return  DrawingTool(tip: ChiselTip.init,
                            stem: stem,
                            shaft: shaft,
                            color: color,
                            opacity: opacity,
                            width: width,
                            stemInset: 0,
                            tipInset: 3)
    }
    
}
