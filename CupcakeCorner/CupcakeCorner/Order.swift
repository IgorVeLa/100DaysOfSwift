//
//  Order.swift
//  CupcakeCorner
//
//  Created by Igor L on 29/12/2023.
//

import SwiftUI
import Foundation

@Observable
class Order: Identifiable, Codable {
    var id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    // challenge 3
    var name = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(name) {
                UserDefaults.standard.set(encoded, forKey: "addressName")
            }
        }
    }
    var streetAddress = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(streetAddress) {
                UserDefaults.standard.set(encoded, forKey: "addressStreet")
            }
        }
    }
    var city = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(city) {
                UserDefaults.standard.set(encoded, forKey: "addressCity")
            }
        }
    }
    var zip = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(zip) {
                UserDefaults.standard.set(encoded, forKey: "addressZip")
            }
        }
    }
    
    var hasValidAddress: Bool {
        // challenge 1
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        
        if name.trimmingCharacters(in: whitespace).isEmpty || streetAddress.trimmingCharacters(in: whitespace).isEmpty || city.trimmingCharacters(in: whitespace).isEmpty || zip.trimmingCharacters(in: whitespace).isEmpty {
            return false
        }

        return true
    }
    
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
    
    // challenge 3
    init() {
        if let savedAddressName = UserDefaults.standard.data(forKey: "addressName"),
           let savedAddressStreet = UserDefaults.standard.data(forKey: "addressStreet"),
           let savedAddressCity = UserDefaults.standard.data(forKey: "addressCity"),
           let savedAddressZip = UserDefaults.standard.data(forKey: "addressZip") {
            if let decodedName = try? JSONDecoder().decode(String.self, from: savedAddressName),
               let decodedStreet = try? JSONDecoder().decode(String.self, from: savedAddressStreet),
               let decodedCity = try? JSONDecoder().decode(String.self, from: savedAddressCity),
               let decodedZip = try? JSONDecoder().decode(String.self, from: savedAddressZip){
                name = decodedName
                streetAddress = decodedStreet
                city = decodedCity
                zip = decodedZip
                return
            }
        }

        name = ""
        streetAddress = ""
        city = ""
        zip = ""
    }
}
