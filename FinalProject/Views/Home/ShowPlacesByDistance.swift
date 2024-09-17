//
//  ShowPlacesByDistance.swift
//  FinalProject
//
//  Created by Rishi Garg on 3/21/24.
//

import SwiftUI
import MapKit

struct ShowPlacesByDistance: View {
    @StateObject var viewModel = DestinationViewModel()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), // Default to LA coordinates
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    var body: some View {
        VStack {
            Map()
        }
    }
    
    var annotations: [Place] {
        var places = [Place]()
        if let currentLocation = viewModel.currentLocation {
            places.append(Place(mapItem: MKMapItem(placemark: MKPlacemark(coordinate: currentLocation)), type: .user))
        }
        if let destinationLocation = viewModel.destinationLocation {
            places.append(Place(mapItem: destinationLocation, type: .destination))
        }
        return places
    }
}

struct Place: Identifiable {
    let id = UUID()
    var mapItem: MKMapItem
    var type: PlaceType
}

enum PlaceType {
    case user, destination
}

