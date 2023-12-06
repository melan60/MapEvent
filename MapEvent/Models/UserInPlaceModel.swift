//
//  UserInPlaceModel.swift
//  MapEvent
//
//  Created by benoit melanie on 06/12/2023.
//

import Foundation

struct UserInPlace: Decodable, Hashable {
    var date: Date
    var users: [User]
}
