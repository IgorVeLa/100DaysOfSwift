//
//  Student.swift
//  BookWorm
//
//  Created by Igor L on 04/01/2024.
//


import Foundation
import SwiftData


@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
