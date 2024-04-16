//
//  PreviewSampleData.swift
//  DiceRoll
//
//  Created by Igor L on 16/04/2024.
//

import Foundation
import SwiftData

let previewContainer: ModelContainer = {
    // how and where data is stored within the database
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    do {
        // creates the actual database and manages database file
        let container = try ModelContainer(for: Roll.self, configurations: config)
        
        Task { @MainActor in
            // tracks data that has been created, modified and deleted in memory to be added to container
            let context = container.mainContext
            
            let roll1 = Roll(number: Int.random(in: 1...6))
            let roll2 = Roll(number: Int.random(in: 1...6))
            let roll3 = Roll(number: Int.random(in: 1...6))
            let roll4 = Roll(number: Int.random(in: 1...6))
            let roll5 = Roll(number: Int.random(in: 1...6))
            let roll6 = Roll(number: Int.random(in: 1...6))
            
            context.insert(roll1)
            context.insert(roll2)
            context.insert(roll3)
            context.insert(roll4)
            context.insert(roll5)
            context.insert(roll6)
        }
        
        return container
    } catch {
        fatalError("Failed to make a container \(error.localizedDescription)")
    }
}()
