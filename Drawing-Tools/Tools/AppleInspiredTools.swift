// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

// MARK: - Apple Inspired tools

extension DrawingTool where Shaft == BandedShaft {
    
    static func pen(color: Color, opacity: Double = 1, width: CGFloat = 100, bandThickness: CGFloat = 40) -> DrawingTool where Tip == RoundedTriangleTip, Stem == BrushStem  {
        DrawingTool(tip: RoundedTriangleTip.init,
                    stem: BrushStem.init,
                    shaft: BandedShaft(color: color, opacity: opacity, width: width, bandThickness: bandThickness),
                    color: color,
                    opacity: opacity,
                    width: width,
                    stemInset: 0,
                    tipInset: 0)
    }
    
    static func marker(color: Color, opacity: Double = 1, width: CGFloat = 100, bandThickness: CGFloat = 40) -> DrawingTool where Tip == ChiselTip, Stem == BeerGlassStem  {
        DrawingTool(tip: ChiselTip.init,
                    stem: BeerGlassStem.init,
                    shaft: BandedShaft(color: color, opacity: opacity, width: width, bandThickness: bandThickness),
                    color: color,
                    opacity: opacity,
                    width: width,
                    stemInset: 0,
                    tipInset: 2)
    }
    
}
