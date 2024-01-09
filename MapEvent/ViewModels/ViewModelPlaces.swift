//
//  ViewModel.swift
//  MapEvent
//
//  Created by benoit melanie on 05/12/2023.
//

import Foundation
import SwiftUI
import CoreLocation

@MainActor
class ViewModelPlaces: ObservableObject {
    enum State {
        case notAvailable
        case loading
        case success(data: [Location])
        case failed(error: Error)
    }
    
    private let service: ApiService
    
    @Published var state: State = .notAvailable
    
    init(service: ApiService) {
        self.service = service
    }
    
    func getAllPlaces() async {
        self.state = .loading
        do {
            var locations : [Location] = []
            let places = try await service.fetchAllPlaces()
            for i in 0...places.count-1 {
                locations.append(Location(id_place: places[i].id_place, name: places[i].place_name, coordinate: CLLocationCoordinate2D(latitude: Double(places[i].latitude), longitude: Double(places[i].longitude))))
            }
            print("\n\n\n")
            print(locations)
            print(places)
            self.state = .success(data: locations)
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
    }
}
