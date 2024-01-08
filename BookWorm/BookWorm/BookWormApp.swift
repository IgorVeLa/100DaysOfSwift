//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Igor L on 04/01/2024.
//


import SwiftData
import SwiftUI


@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
