// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

extension HorizontalAlignment {
    struct UpfrontLine: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.trailing]
        }
    }

    static let upfrontLine = HorizontalAlignment(UpfrontLine.self)
}


struct OmniRectEditor: View {
    @State var edgeStyles: EdgeStyles = EdgeStyles(curvature: 0)
    @State var cornerStyles: CornerStyles = .allSquare()
    @State var color: Color = .black
    static let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.maximumFractionDigits = 3
        
        return f
    }()
    
    
    func makeCornerTool(_ value: Binding<Corner>, _ name: String) -> some View  {
        HStack {
            Text(name)
                .frame(width: 100, alignment: .trailing)
            Picker("Some", selection: value.style) {
                ForEach(Corner.Style.allCases) { (style) in
                    Text(style.rawValue)
                        .tag(style)
                        .fixedSize()
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            TextField("", value: value.value, formatter: Self.formatter)
        }
    }
    
    var body: some View {
        VStack {
            OmniRectangle(corners: cornerStyles, edges: edgeStyles)
                .fill(color)
                .frame(width: 150, height: 150)
                .padding()
                .animation(.linear)
            VStack(alignment: .upfrontLine) {
                makeCornerTool($cornerStyles.topLeft, "Top left")
                makeCornerTool($cornerStyles.topRight, "Top right")
                makeCornerTool($cornerStyles.bottomLeft, "Bottom left")
                makeCornerTool($cornerStyles.bottomRight, "Bottom right")
            }
            Form {
                ColorPicker("Dang thats a color", selection: $color)
                VStack(alignment: .leading) {
                    Text("Top Curvature: \(String(format: "%.2f", Double(edgeStyles.topCurvature)))")
                    Slider(value: $edgeStyles.topCurvature, in: -1...1)
                }
                
                VStack(alignment: .leading) {
                    Text("Bottom Curvature: \(String(format: "%.2f", Double(edgeStyles.bottomCurvature)))")
                    Slider(value: $edgeStyles.bottomCurvature, in: -1...1)
                }
                
                VStack(alignment: .leading) {
                    Text("Left Curvature: \(String(format: "%.2f", Double(edgeStyles.leftCurvature)))")
                    Slider(value: $edgeStyles.leftCurvature, in: -1...1)
                }
                
                VStack(alignment: .leading) {
                    Text("Right Curvature: \(String(format: "%.2f", Double(edgeStyles.rightCurvature)))")
                    Slider(value: $edgeStyles.rightCurvature, in: -1...1)
                }
            }
        }
    }
}

struct OmniRectEditor_Previews: PreviewProvider {
    static var previews: some View {
        OmniRectEditor()
    }
}
