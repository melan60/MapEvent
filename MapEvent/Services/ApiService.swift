//
//  Service.swift
//  MapEvent
//
//  Created by benoit melanie on 05/12/2023.
//

import Foundation

enum ApiError: Error {
    case failed
    case failedToDecode
    case invalidStatusCode
    case invalidUserName
    case invalidUrl
}

struct ApiService {
    let baseUrl = "http://10.248.3.231:3000"
    
    func fetchAllPlaces() async throws -> [Place] {
        let endpoint = baseUrl + "/places"
        
        guard let url = URL(string: endpoint) else {
            throw ApiError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidStatusCode
        }
        
        let decodedData = try JSONDecoder().decode([Place].self, from: data)
        
        return decodedData
    }
    
    func fetchAllPersons() async throws -> [Person] {
        let endpoint = baseUrl + "/users"
        
        guard let url = URL(string: endpoint) else {
            throw ApiError.invalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from:url)

        let decodedData = try JSONDecoder().decode([Person].self, from: data)
//        print(decodedData)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidStatusCode
        }

        return decodedData
    }
    
    func fetchPersonsByPlace(for id_place: Int) async throws -> [Person] {
        let endpoint = baseUrl + "/places/isin/\(id_place)"
        
        guard let url = URL(string: endpoint) else {
            throw ApiError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidStatusCode
        }
        
        let decodedData = try JSONDecoder().decode([Person].self, from: data)
        
        return decodedData
    }
    
    func addPlace(id_place: Int, id_person: Int) async throws {
        let endpoint = baseUrl + "/places/\(id_place)/\(id_person)"

        guard let url = URL(string: endpoint) else {
            throw ApiError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiError.invalidStatusCode
        }
    }
    
    func deletePlace(id_person: Int) async throws {
        let endpoint = baseUrl + "/places/\(id_person)"

        guard let url = URL(string: endpoint) else {
            throw ApiError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiError.invalidStatusCode
        }
    }
    
    // update all
    // update place user
}
