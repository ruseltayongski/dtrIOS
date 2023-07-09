//
//  MapViewCirlcle.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/24/23.
//

import SwiftUI
import MapKit

struct MapViewCirlcle: View {
    
    @StateObject private var mapYM = MapViewModels()
    
    var body: some View {
        ZStack {
            MKMapRep(mapVM: mapYM)
                .ignoresSafeArea()
                .alert(isPresented: $mapYM.alertOutOfBounds) {
                    Alert(title: Text("Out of Bounds!!"), message: Text("You are out of bounds from the circle!"), dismissButton: .default(Text("OK")))
                }
        }
    }
    
//    var body: some View {
//        ZStack {
//            Color.white // Or any other view that doesn't block the main thread
//            
//            if mapYM.isLoaded {
//                MKMapRep(mapVM: mapYM)
//                    .ignoresSafeArea()
//            } else {
//                ProgressView() // Or any other loading indicator
//            }
//        }
//        .onAppear {
//            DispatchQueue.global().async {
//                // Do any time-consuming data loading or processing here
//                mapYM.loadMapData()
//                
//                DispatchQueue.main.async {
//                    // Update the UI on the main thread when the work is finished
//                    mapYM.isLoaded = true
//                }
//            }
//        }
//    }

}

struct MapViewCirlcle_Previews: PreviewProvider {
    static var previews: some View {
        MapViewCirlcle()
    }
}
