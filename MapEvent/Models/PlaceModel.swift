//
//  FileModel.swift
//  MapEvent
//
//  Created by benoit melanie on 05/12/2023.
//

import Foundation

struct Place: Codable, Hashable {
    var name: String
    var longitude: Float
    var latitude: Float
}
