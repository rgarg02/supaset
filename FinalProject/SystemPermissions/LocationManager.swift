//
//  LocationManager.swift
//  FinalProject
//
//  Created by Rishi Garg on 3/22/24.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI
class DestinationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var destinationLocation: MKMapItem?
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
    
    private func generateRandomDestination() {
        guard let userLocation = locationManager.location else { return }
        let radius = 100 * 1609.34 // 100 miles in meters
        
        // Generate random point within radius (simplified approach)
        let randomAngle = Double.random(in: 0..<2 * .pi)
        let offset = radius
        let deltaLat = offset * cos(randomAngle) / 111_325
        let deltaLon = offset * sin(randomAngle) / 111_325
        
        let newCoordinate = CLLocationCoordinate2D(
            latitude: userLocation.coordinate.latitude + deltaLat,
            longitude: userLocation.coordinate.longitude + deltaLon
        )
        
        // Search for a placemark at the random point
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "landmark" // You can adjust this query
        request.region = MKCoordinateRegion(center: newCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
        MKLocalSearch(request: request).start { [weak self] response, _ in
            guard let placemark = response?.mapItems.first?.placemark else { return }
            DispatchQueue.main.async {
                self?.destinationLocation = MKMapItem(placemark: placemark)
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    
    func findNewDestination() {
        generateRandomDestination()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.currentLocation = location.coordinate
        }
    }
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    func locationStatus() -> Color {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            return Color.gray
        case .restricted:
            return Color.yellow
        case .denied:
            return Color.red
        case .authorizedAlways:
            return Color.green
        case .authorizedWhenInUse:
            return Color.green
        @unknown default:
            return Color.gray
        }
    }
}
