//
//  UserModel.swift
//  MapEvent
//
//  Created by benoit melanie on 06/12/2023.
//

import Foundation

struct User: Codable, Hashable {
    var firstname: String
    var name: String
    var email: String
    var company: String
    var activity: String
}
