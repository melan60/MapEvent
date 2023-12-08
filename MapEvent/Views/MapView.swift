//
//  MapView.swift
//  MapEvent
//
//  Created by fernandes adrien on 06/12/2023.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @StateObject var viewModelPlaces = ViewModelPlaces(service:ApiService())
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.7235038, longitude: 3.1605714), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        VStack {
            switch(viewModelPlaces.state) {
                case .loading:
                    ProgressView()
                case .success(let locations):
                    Map(coordinateRegion: $region, annotationItems: locations) { location in
                        MapMarker(coordinate: location.coordinate)
                    }
                    .navigationTitle("Map")
                    .edgesIgnoringSafeArea(.all)
                default:
                    EmptyView()
            }
            
        }
        .task {
            await viewModelPlaces.getAllPlaces()
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
