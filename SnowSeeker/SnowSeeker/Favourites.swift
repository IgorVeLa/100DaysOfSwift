//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Igor L on 24/04/2024.
//

import SwiftUI
import SwiftData

@Observable
class Favourites {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let key: String
    
    // challenge 2
    init() {
        // load our saved data
        self.key = "Favourites"
        if let resortsArr = UserDefaults.standard.stringArray(forKey: key) {
            resorts = Set(resortsArr)
            return
        }
        // still here? Use an empty array
        resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set and saves the change
    func add(resort: Resort) {
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set and saves the change
    func remove(resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    
    // challenge 2
    func save() {
        UserDefaults.standard.set(Array(resorts), forKey: key)
    }
}
