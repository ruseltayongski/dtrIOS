//
//  MapView.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/22/23.
//

import MapKit
import SwiftUI

//struct MapView: View {
//    @StateObject private var viewModel = MapViewModel()
//
//    var body: some View {
//        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
//            .ignoresSafeArea()
//            .accentColor(Color(.systemBlue))
//            .onAppear {
//                viewModel.checkIfLocationServicesIsEnabled()
//            }
//    }
//}

//struct MapView: View {
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
//
//    var body: some View {
//        Map(coordinateRegion: $region)
//            .ignoresSafeArea()
//            .transaction { transaction in
//                transaction.animation = .easeInOut(duration: 0.5)
//            }
//            .onAppear {
//                // Simulate frequent updates to the region
//                let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
//                    region.center.latitude += 0.01
//                }
//                RunLoop.current.add(timer, forMode: .common)
//            }
//    }
//}

//struct MapView: View {
//    @StateObject private var viewModel = MapViewModel()
//    @State private var isLoaded = false
//
//    var body: some View {
//        if isLoaded {
//            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
//                .ignoresSafeArea()
//                .transaction { transaction in
//                    transaction.animation = .easeInOut(duration: 0.5)
//                }
//                .accentColor(Color(.systemBlue))
//                .task {
//                     viewModel.checkIfLocationServicesIsEnabled()
//                }
//        } else {
//            ProgressView()
//                .onAppear {
//                    Task {
//                        viewModel.checkIfLocationServicesIsEnabled()
//                        isLoaded = true
//                    }
//                }
//        }
//    }
//}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 10.307746, longitude: 123.893587), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))

    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager!.delegate = self
        } else {
            print("Show an alert letting them know this is off and to go turn it on.")
        }
    }

    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
            case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            case .restricted:
                    print("Your location is restricted likely due to parental controls.")
            case .denied:
                    print("You have denied this app location permission. Go into settings change it.")
            case .authorizedAlways, .authorizedWhenInUse:
                print("authorized work!!")
                self.region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            @unknown default:
                break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

//struct MapView: View {
//    @StateObject private var viewModel = MapViewModel()
//
//    var body: some View {
//        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
//            .ignoresSafeArea()
//            .accentColor(Color(.systemBlue))
//            .onAppear {
//                viewModel.checkIfLocationServicesIsEnabled()
//            }
//    }
//}

//struct MapView: UIViewRepresentable {
//    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 10.307746, longitude: 123.893587), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
//    let circleRadius: CLLocationDistance = 100 // radius in meters
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        return mapView
//    }
//
//    func updateUIView(_ mapView: MKMapView, context: Context) {
//        mapView.setRegion(region, animated: true)
//
//        let circle = MKCircle(center: region.center, radius: circleRadius)
//        mapView.addOverlay(circle)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            if let circleOverlay = overlay as? MKCircle {
//                let circleRenderer = MKCircleRenderer(circle: circleOverlay)
//                circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.2)
//                circleRenderer.strokeColor = UIColor.blue
//                circleRenderer.lineWidth = 2
//                return circleRenderer
//            }
//            return MKOverlayRenderer()
//        }
//    }
//}

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    let locationManager = CLLocationManager()
    let circleRadius: CLLocationDistance = 100 // radius in meters
    @State var items: [CoordinatesAPI] = []
    @State var userLocationGlobal: MKUserLocation? = nil

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        context.coordinator.fetchData()
        mapView.showsUserLocation = true
        // Request authorization for location services
        locationManager.requestWhenInUseAuthorization()
        // Set the delegate for the CLLocationManager
        locationManager.delegate = context.coordinator
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        print("updateview")
        mapView.setRegion(region, animated: true)
        
        
//        let circle = MKCircle(center: region.center, radius: circleRadius)
//        mapView.addOverlay(circle)
//
//        let newRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 10.307157, longitude: 123.894303), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
//
//        let newCircle = MKCircle(center: newRegion.center, radius: circleRadius)
//        mapView.addOverlay(newCircle)
        
        items.forEach { item in
            if let latitude = Double(item.latitude), let longitude = Double(item.longitude) {
                let newRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                let circle = MKCircle(center: newRegion.center, radius: item.radius)
                mapView.addOverlay(circle)
                
                let latitudeChecker = userLocationGlobal?.coordinate.latitude ?? 0.0
                let longitudeChecker = userLocationGlobal?.coordinate.longitude ?? 0.0
                let userLocation = CLLocation(latitude: latitudeChecker, longitude: longitudeChecker)
                let centerLocation = CLLocation(latitude: latitude, longitude: longitude)
                let distanceFromCenter = userLocation.distance(from: centerLocation)

                if distanceFromCenter > item.radius {
                    print("User is outside the circle.")
                } else {
                    print("User is inside the circle.")
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: MapView
        
        func fetchData() {
            guard let url = URL(string: "http://49.157.74.3/dtr/mobileV3/area_of_assignment?userid=0454") else {
                 print("Invalid URL")
                return
            }
        
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    return
                }
        
                do {
                    let decodedData = try JSONDecoder().decode([CoordinatesAPI].self, from: data)
                    DispatchQueue.main.async {
                        self.parent.items = decodedData
                    }
                } catch {
                    print(error)
                }
            }.resume()
        }

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circleOverlay = overlay as? MKCircle {
                let circleRenderer = MKCircleRenderer(circle: circleOverlay)
                circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.2)
                circleRenderer.strokeColor = UIColor.blue
                circleRenderer.lineWidth = 2
                return circleRenderer
            }
            return MKOverlayRenderer()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            print("mapview")
            self.parent.userLocationGlobal = userLocation
            let userCoordinate = userLocation.coordinate
            print("User location: \(userCoordinate.latitude), \(userCoordinate.longitude)")
            
            if self.parent.items.count > 0 {
                self.parent.items.forEach { item in
                    if let latitude = Double(item.latitude), let longitude = Double(item.longitude) {
                        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
                        let centerLocation = CLLocation(latitude: latitude, longitude: longitude)
                        let distanceFromCenter = userLocation.distance(from: centerLocation)

                        if distanceFromCenter > item.radius {
                            print("User is outside the circle.")
                        } else {
                            print("User is inside the circle.")
                        }
                    }
                }
            }
            
//            let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
//            let centerLocation = CLLocation(latitude: parent.region.center.latitude, longitude: parent.region.center.longitude)
//            let distanceFromCenter = userLocation.distance(from: centerLocation)
//
//            if distanceFromCenter > parent.circleRadius {
//                print("User is outside the circle.")
//            } else {
//                print("User is inside the circle.")
//            }
        }

        // Handle changes to the authorization status
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                print("Location services authorized.")
            case .denied, .restricted:
                print("Location services not authorized.")
            case .notDetermined:
                print("Location services not yet determined.")
            @unknown default:
                fatalError("Unknown authorization status.")
            }
        }
        
    }
    
}

struct MapViewContent: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 10.307746, longitude: 123.893587), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    @State private var newRegion = CLLocationCoordinate2D(latitude: 10.307157, longitude: 123.894303) // new coordinate for circle

    var body: some View {
        MapView(region: $region)
            .ignoresSafeArea()
    }
}

struct CoordinatesAPI: Codable {
    let name: String
    let latitude: String
    let longitude: String
    let radius: Double
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapViewContent()
    }
}


