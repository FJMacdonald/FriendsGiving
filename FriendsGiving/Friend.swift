//
//  Friend.swift
//  FriendsGiving
//
//  Created by Francesca MACDONALD on 2023-08-28.
//

import Foundation

struct Friend: Codable, Identifiable {
    var id: String?
    var name = "" // Friends name
    var bringing = "" // What friend is bringing
    var notes = "" // Notes, like alergies or special seating considerations
}
