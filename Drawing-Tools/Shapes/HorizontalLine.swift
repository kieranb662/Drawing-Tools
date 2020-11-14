// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

public struct HorizontalLine: Shape {
    var offset: CGFloat

    /// A horizontal line that is the width of its container
    /// -   parameter offset: A value between 0 and 1 defining the lines vertical offset in its container (**Default**: 0.5)
    public init(offset: CGFloat = 0.5) {
        self.offset = offset
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: rect.maxY*offset))
            path.addLine(to: CGPoint(x: rect.width, y: rect.maxY*offset))
        }
    }
}
