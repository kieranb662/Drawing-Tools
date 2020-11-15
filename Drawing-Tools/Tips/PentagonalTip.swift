// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct PentagonalTip: View {
    var color: Color = Color.purple
    var width: CGFloat = 20
    private var scaleFactor: CGFloat {
        width > 0 ? width/standardWidth : 1
    }
    private let standardWidth: CGFloat = 20
    private let triangleHeight: CGFloat = 23
    private let rectangleHeight: CGFloat = 15
    
    init(color: Color, width: CGFloat = 50) {
        self.color = color
        self.width = width
    }
    
    var body: some View {
        VStack(spacing: 0) {
            triangle
            rectangle
        }
    }
    
    var triangle: some View {
        Triangle()
            .fill(color)
            .overlay(Triangle()
                        .strokeBorder(color, style: StrokeStyle(lineWidth: 5, lineJoin: .round)))
            .frame(width: width, height: scaleFactor*triangleHeight)
            .offset(y: 2)
    }
    
    var rectangle: some View {
        Rectangle()
            .fill(color)
            .overlay(Rectangle()
                        .strokeBorder(color, style: StrokeStyle(lineWidth: 5, lineJoin: .round)))
            .brightness(0.05)
            .frame(width: width, height: scaleFactor*rectangleHeight)
    }
}

struct PentagonalTip_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            PentagonalTip(color: .purple)
            PentagonalTip(color: .purple,width: 200)
            PentagonalTip(color: .purple,width: 10)
        }
    }
}
