//
//  ViewModel.swift
//  MapEvent
//
//  Created by benoit melanie on 05/12/2023.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
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
    
    func getAllPersons() async throws -> Person {
        let persons = try await service.fetchAllPersons()
        print(persons)
        return persons[0]
    }
    
    func updatePersons(for person: Person) async {
        self.state = .loading
        do {
            let persons = try await service.updatePerson(for: person)
            self.state = .success(data: persons)
            print(persons)
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
    }
}
