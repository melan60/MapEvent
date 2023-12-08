//
//  UserInPlaceModel.swift
//  MapEvent
//
//  Created by benoit melanie on 06/12/2023.
//

import Foundation

struct UserInPlace: Decodable, Hashable {
    var date: TimeInterval
    var id_user: Int
    var id_place : Int
}
