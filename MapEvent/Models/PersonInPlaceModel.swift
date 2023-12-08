//
//  UserInPlaceModel.swift
//  MapEvent
//
//  Created by benoit melanie on 06/12/2023.
//

import Foundation

struct PersonInPlace: Decodable, Hashable {
    var date: TimeInterval
    var id_person: Int
    var id_place : Int
}
