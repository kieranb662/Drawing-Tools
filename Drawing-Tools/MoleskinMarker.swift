// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct TieredStem: View {
    var antennaColor: Color = .gray
    var antennaSize: CGSize = CGSize(width: 15, height: 30)
    var antennaCornerRadius: CGFloat = 2
    
    var trapezoid1Color: Color = Color(white: 0.4)
    var trapezoid1Size: CGSize = CGSize(width: 40, height: 10)
    var trapezoid1BaseRatio: CGFloat = 0.5
    
    var tier1Color: Color = Color(white: 0.2)
    var tier1Size: CGSize = CGSize(width: 40, height: 10)
    var tier1TopColor: Color = Color(white: 0.3)
    var tier1BottomColor: Color = Color(white: 0.3)
    
    var tier2Color: Color = .black
    var tier2Size: CGSize = CGSize(width: 50, height: 10)
    var tier2BottomColor: Color = Color(white: 0.3)
    var tier2CornerRadius: CGFloat = 3
    
    var trapezoid2Color: Color = .black
    var trapezoid2Size: CGSize = CGSize(width: 75, height: 125)
    var trapezoid2BaseRatio: CGFloat = 0.8
    
    var tier3Color: Color = Color(white: 0.2)
    var tier3Size: CGSize = CGSize(width: 90, height: 25)
    var tier3BottomColor: Color = Color(white: 0.3)
    var tier3CornerRadius: CGFloat = 2
    var bandColor: Color = Color(white: 0.05)
    var bandThickness: CGFloat = 3
    
    var body: some View {
        antenna
        trapezoid1
        tier1
        tier2
        trapezoid2
        tier3
    }
    
    var antenna: some View {
        OmniRectangle(topLeft: .round(radius: antennaCornerRadius),
                      topRight: .round(radius: antennaCornerRadius),
                      bottomLeft: .square,
                      bottomRight: .square)
            .fill(antennaColor)
            .frame(width: antennaSize.width, height: antennaSize.height)
    }
    
    var trapezoid1: some View {
        Trapezoid(baseRatio: trapezoid1BaseRatio)
            .fill(trapezoid1Color)
            .frame(width: trapezoid1Size.width, height: trapezoid1Size.height)
    }
    
    var tier1: some View {
        Rectangle()
            .fill(tier1Color)
            .overlay(HorizontalLine(offset: 0)
                        .stroke(tier1TopColor, style: StrokeStyle(lineCap: .butt)), alignment: .top)
            .overlay(HorizontalLine(offset: 1)
                        .stroke(tier1BottomColor), alignment: .bottom)
            .frame(width: tier1Size.width, height: tier1Size.height)
    }
    
    var tier2: some View {
        OmniRectangle(topLeft: .round(radius: tier2CornerRadius),
                      topRight: .round(radius: tier2CornerRadius),
                      bottomLeft: .square,
                      bottomRight: .square)
            .fill(tier2Color)
            .frame(width: tier2Size.width, height: tier2Size.height)
            .overlay(HorizontalLine(offset: 1)
                        .stroke(tier2BottomColor),
                     alignment: .bottom)
    }
    
    var trapezoid2: some View {
        Trapezoid(baseRatio: trapezoid2BaseRatio)
            .fill(trapezoid2Color)
            .frame(width: trapezoid2Size.width, height: trapezoid2Size.height)
    }
    
    var tier3: some View {
        OmniRectangle(topLeft: .round(radius: tier3CornerRadius),
                      topRight: .round(radius: tier3CornerRadius),
                      bottomLeft: .square,
                      bottomRight: .square)
            .fill(tier3Color)
            .frame(width: tier3Size.width, height: tier3Size.height)
            .overlay(HorizontalLine(offset: 0.3)
                        .stroke(bandColor, lineWidth: bandThickness))
    }
    
}

struct MoleskinMarker: View {
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                OmniRectangle(topLeft: .round(radius: 2),
                              topRight: .round(radius: 2),
                              bottomLeft: .square,
                              bottomRight: .square)
                    .fill(Color.purple)
                    .frame(width: 12, height: 15)
                TieredStem()
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.purple)
                    .frame(width: 100)
            }.frame(maxHeight: 600)
        }
    }
}

struct MoleskinMarker_Previews: PreviewProvider {
    static var previews: some View {
        MoleskinMarker()
    }
}
