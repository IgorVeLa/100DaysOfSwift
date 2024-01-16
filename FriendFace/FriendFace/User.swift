//
//  User.swift
//  FriendFace
//
//  Created by Igor L on 13/01/2024.
//

import Foundation

struct User: Identifiable, Codable {
    enum CodingKeys: CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        case friends
    }
    
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}

extension User: Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
            return lhs.id == lhs.id && rhs.name == rhs.name
        }


        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
        }
}
