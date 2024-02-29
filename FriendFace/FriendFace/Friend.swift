//
//  Friend.swift
//  FriendFace
//
//  Created by Igor L on 15/02/2024.
//

import SwiftUI
import Foundation

struct Friend: Hashable, Codable, Comparable {
    var id = UUID()
    var imageData: Data
    var image: Image {
        guard let uiImage = UIImage(data: imageData) else {
            return Image(uiImage: .remove)
        }
        
        let image = Image(uiImage: uiImage)
        
        return image
    }
    var name: String
}

extension Friend {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func <(lhs: Friend, rhs: Friend) -> Bool {
        lhs.name < rhs.name
    }
}
