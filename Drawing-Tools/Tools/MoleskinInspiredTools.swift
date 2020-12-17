// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

// MARK: - Moleskin Inspired tools

extension DrawingTool {
    
    static func chiselMarker(color: Color, opacity: Double = 1, width: CGFloat = 100) -> DrawingTool where Tip == ChiselTip, Stem == ConcaveStem, Shaft == RoundedShaft   {
        DrawingTool(tip: ChiselTip.init,
                    stem: ConcaveStem.init,
                    shaft: RoundedShaft.init,
                    color: color,
                    opacity: opacity,
                    width: width,
                    stemInset: 5,
                    tipInset: 2)
    }
    
    static func roundMarker(color: Color, opacity: Double = 1, width: CGFloat = 100) -> DrawingTool where Tip == BulletTip, Stem == ConcaveStem, Shaft == RoundedShaft  {
        DrawingTool(tip: BulletTip.init,
                    stem: ConcaveStem.init,
                    shaft: RoundedShaft.init,
                    color: color,
                    opacity: opacity,
                    width: width,
                    stemInset: 5,
                    tipInset: 4)
    }
    
    static func graphitePencil(color: Color, opacity: Double = 1, width: CGFloat = 100) -> DrawingTool where Tip == PentagonalTip, Stem == GemStem, Shaft == RoundedShaft  {
        DrawingTool(tip: PentagonalTip.init,
                    stem: GemStem.init,
                    shaft: RoundedShaft.init,
                    color: color,
                    opacity: opacity,
                    width: width,
                    stemInset: 5,
                    tipInset: 3)
    }
    
    
    static func fineTipPen(color: Color, opacity: Double = 1, width: CGFloat = 100) -> DrawingTool where Tip == FineTip, Stem == TieredStem, Shaft == RoundedShaft  {
        DrawingTool(tip: FineTip.init,
                    stem: TieredStem.init,
                    shaft: RoundedShaft.init,
                    color: color,
                    opacity: opacity,
                    width: width,
                    stemInset: 5,
                    tipInset: 2)
    }
}
