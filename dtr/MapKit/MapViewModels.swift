//
//  MapViewModel.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/24/23.
//

import Foundation
import SwiftUI
import MapKit

final class MapViewModels: NSObject, ObservableObject {
    @Published var mapRegion: MKCoordinateRegion = .init(center: .init(latitude: 10.307746, longitude: 123.893587), span: .init(latitudeDelta: 0.010, longitudeDelta: 0.010))
    
    @Published var alertOutOfBounds = false
}

extension MapViewModels: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        if let dragAnnotation = view.annotation as? DragAnnotation, let circle = mapView.overlays.first as? MKCircle, newState.rawValue == 4 {
            alertOutOfBounds = dragAnnotation.isOutOfBounds(from: circle)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKCircle {
            let boundCircle = MKCircleRenderer(overlay: overlay)
            boundCircle.strokeColor = UIColor.orange
            boundCircle.fillColor = UIColor.orange.withAlphaComponent(0.25)
            
            return boundCircle
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is DragAnnotation {
            let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            marker.markerTintColor = .orange
            marker.isDraggable = true
            
            return marker
        }
        return nil
    }
    
}

