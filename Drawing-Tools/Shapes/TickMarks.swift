// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

public struct TickMarks: Shape {
    public var spacing: CGFloat
    public var ticks: Int
    public var isVertical: Bool

    /// Creates `ticks` number of tickmarks of varying sizes each spaced apart with the given `spacing`
    ///
    /// ## Example Usage
    /// ```
    ///    struct Ruler: View {
    ///        var length: CGFloat = 600
    ///        @State private var offset: CGSize = .zero
    ///        @State private var dragState: CGSize = .zero
    ///        @State private var angle: Angle = Angle(degrees: -45)
    ///        @State private var rotationState: Angle = .zero
    ///
    ///        var body: some View {
    ///            VStack(alignment: .leading, spacing: 0) {
    ///                TickMarks(spacing: 10, ticks: Int(length/10))
    ///                    .stroke(Color.gray)
    ///                    .frame(height: 50)
    ///                values
    ///                    .offset(x: -10)
    ///            }
    ///            .frame(width: length)
    ///            .padding(.leading)
    ///            .background(Color.pink.opacity(0.5))
    ///            .rotationEffect(angle + rotationState)
    ///            .gesture(dragGesture)
    ///            .offset(x: offset.width + dragState.width,
    ///                    y: offset.height + dragState.height)
    ///            .simultaneousGesture(rotationGesture)
    ///        }
    ///
    ///        // Create the text for every 100 points
    ///        var values: some View {
    ///            let size = 0..<Int(1 + length/100)
    ///
    ///            return HStack(spacing: 70) {
    ///                ForEach(size) { (i)  in
    ///                    Text("\(i*100)")
    ///                        .font(.system(size: 10))
    ///                        .frame(width: 30)
    ///                }
    ///            }
    ///        }
    ///
    ///        var dragGesture: some Gesture {
    ///            DragGesture(minimumDistance: 0, coordinateSpace: .global)
    ///                .onChanged { self.dragState = $0.translation }
    ///                .onEnded { (value) in
    ///                    self.offset.width += value.translation.width
    ///                    self.offset.height += value.translation.height
    ///                    self.dragState = .zero
    ///                }
    ///        }
    ///
    ///        var rotationGesture: some Gesture {
    ///            RotationGesture()
    ///                .onChanged { self.rotationState = $0 }
    ///                .onEnded { (angle) in
    ///                    self.rotationState = .zero
    ///                    self.angle += angle
    ///                }
    ///        }
    ///    }
    ///```
    public init(spacing: CGFloat, ticks: Int, isVertical: Bool = false) {
        self.spacing = spacing
        self.ticks = ticks
        self.isVertical = true
    }

    func determineHeight(_ i: Int) -> CGFloat {
        if i%100 == 0 { return 1    }
        if i%10 == 0  { return 0.75 }
        if i%5 == 0   { return 0.5  }
        return 0.25
    }
    
    private func verticalPath(in rect: CGRect) -> Path {
        Path { path in
            for i in 0...ticks {
                path.move(to: CGPoint(x: 0, y: CGFloat(i)*spacing))
                path.addLine(to: CGPoint(x: rect.width*self.determineHeight(i), y: CGFloat(i)*spacing))
            }
        }
    }
    
    private func horizontalPath(in rect: CGRect) -> Path {
        Path { path in
            for i in 0...ticks {
                path.move(to: CGPoint(x: CGFloat(i)*spacing, y: 0))
                path.addLine(to: CGPoint(x: CGFloat(i)*spacing, y: rect.height*self.determineHeight(i)))
            }
        }
    }

    public func path(in rect: CGRect) -> Path {
        isVertical ? verticalPath(in: rect) : horizontalPath(in: rect)
    }
}

