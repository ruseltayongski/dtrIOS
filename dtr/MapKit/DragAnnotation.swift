//
//  DragAnnotation.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/24/23.
//

import Foundation
import MapKit
import MapKit

class DragAnnotation: NSObject, MKAnnotation {
    var title: String?
    var location: CLLocation!
    var coordinate: CLLocationCoordinate2D {
        didSet {
            self.location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
    func isOutOfBounds(from circle: MKCircle) -> Bool {
        let circleLocation = CLLocation(latitude: circle.coordinate.latitude, longitude: circle.coordinate.longitude)
        
        if self.location != nil {
            return self.location.distance(from: circleLocation) > circle.radius
        }
        return false
    }
}
