//
//  Hot_ProspectsApp.swift
//  Hot Prospects
//
//  Created by Igor L on 05/03/2024.
//

import SwiftUI
import SwiftData

@main
struct Hot_ProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
