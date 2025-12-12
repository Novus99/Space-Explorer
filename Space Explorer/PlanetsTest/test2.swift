import SwiftUI
import RealityKit

struct PlanetScreen: View {
    var body: some View {
        //        VStack {
        //            // Ziemia
        //            //PlanetRealityView(kind: .earth)
        //              //  .frame(height: 300)
        //
        //            // Saturn
        //            PlanetRealityView(kind: .saturn)
        //                .frame(height: 300)
        //        }
        //        .ignoresSafeArea()
        //        .background(.black)
        //    }
        SolarSystemRealityView()
            .background(.black)
            .frame(width: 600, height: 600)
        
    }
}
