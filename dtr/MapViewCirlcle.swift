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
}

struct MapViewCirlcle_Previews: PreviewProvider {
    static var previews: some View {
        MapViewCirlcle()
    }
}
