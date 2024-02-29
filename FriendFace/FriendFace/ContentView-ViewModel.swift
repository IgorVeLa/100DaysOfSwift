//
//  ContentView-ViewModel.swift
//  FriendFace
//
//  Created by Igor L on 29/02/2024.
//

import Foundation
import SwiftUI

extension ContentView {
    @Observable
    class ViewModel {
        var friends = [Friend]()
        var showingFriendView = false
        
        init() {
            do {
                let savePath = URL.documentsDirectory.appending(path: "Friends")
                let data = try Data(contentsOf: savePath)
                friends = try JSONDecoder().decode([Friend].self, from: data)
            } catch {
                friends = []
            }
        }
    }
}

