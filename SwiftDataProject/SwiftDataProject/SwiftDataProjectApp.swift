//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Igor L on 09/01/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
