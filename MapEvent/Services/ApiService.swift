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
    let baseUrl = "http://10.248.1.55:3000"
    
    func fetchPlaces() async throws -> [Place] {
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
        print(data)
        let decodedData = try JSONDecoder().decode([Person].self, from: data)
        print(decodedData)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidStatusCode
        }

        print("marfiphe")
//        let decodedData = try JSONDecoder().decode([Person].self, from: data)
//        print(decodedData)

        return decodedData
    }
    
    func fetchPersonsByPlace(for place: String) async throws -> [Person] {
        let endpoint = baseUrl + "/users?place=\(place)"
        
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
        
    // update all
    // update place user
}
