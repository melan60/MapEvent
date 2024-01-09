//
//  ViewModelPersonInPlace.swift
//  MapEvent
//
//  Created by beaudru messaline on 09/01/2024.
//

import Foundation

@MainActor
class ViewModelPersonInPlace : ObservableObject{
    enum State {
        case notAvailable
        case loading
        case success(data: [Person])
        case failed(error: Error)
    }

    private let service: ApiService

    @Published var state: State = .notAvailable
    
    init(service: ApiService) {
        self.service = service
    }
    
    func getAllPersonsByPlace(id_place: Int) async {
        self.state = .loading

        do {
            let persons = try await service.fetchPersonsByPlace(for: id_place)
            print("\n\n")
            print(persons)
            self.state = .success(data: persons)
        } catch {
            print(error)
            self.state = .failed(error: error)
        }
    }

    func addPlace(id_place: Int, id_person: Int) async {
        self.state = .loading

        do {
            try await service.addPlace(id_place: id_place, id_person: id_person)
        } catch {
            print(error)
            self.state = .failed(error: error)
        }
    }
    
    func deletePlace(id_person: Int) async {
        self.state = .loading

        do {
            try await service.deletePlace(id_person: id_person)
        } catch {
            print(error)
            self.state = .failed(error: error)
        }
    }
}
