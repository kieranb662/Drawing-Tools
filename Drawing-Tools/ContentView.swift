// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            HStack(alignment: .top) {
                Marker(tip: ChiselTip.init,
                       stem: BeerGlassStem.init,
                       shaft: BandedShaft.init,
                       color: .yellow,
                       opacity: 1,
                       width: 100,
                       stemInset: 0,
                       tipInset: 5)
                
                Marker(tip: ChiselTip.init,
                       stem: TieredStem.init,
                       shaft: BandedShaft.init,
                       color: .blue,
                       opacity: 1,
                       width: 100,
                       stemInset: 0,
                       tipInset: 0)
                
                
                Marker(tip: BulletTip.init,
                       stem: ConcaveStem.init,
                       shaft: RoundedShaft.init,
                       color: .green,
                       opacity: 1,
                       width: 100,
                       stemInset: 5,
                       tipInset: 3)
                
                Marker(tip: PentagonalTip.init,
                       stem: GemStem.init,
                       shaft: RoundedShaft.init,
                       color: .orange,
                       opacity: 1,
                       width: 100,
                       stemInset: 5,
                       tipInset: 3)
                
                Marker(tip: RoundedTriangleTip.init,
                       stem: BrushStem.init,
                       shaft: BandedShaft.init,
                       color: .blue,
                       opacity: 1,
                       width: 100,
                       stemInset: 0,
                       tipInset: 0)
 
            }
        }.frame(maxHeight: 600)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
