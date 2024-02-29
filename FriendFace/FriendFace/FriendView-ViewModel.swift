//
//  FriendView-ViewModel.swift
//  FriendFace
//
//  Created by Igor L on 29/02/2024.
//

import Foundation
import PhotosUI
import SwiftUI

extension FriendView {
    @Observable
    class ViewModel {
        var friends: [Friend]
        
        // reference to image from user gallery
        var pickerItem: PhotosPickerItem?
        // actual image
        var selectedImage: Image?
        var name = ""
        
        init(friends: [Friend], pickerItem: PhotosPickerItem? = nil, selectedImage: Image? = nil, name: String = "") {
            self.friends = friends
            self.pickerItem = pickerItem
            self.selectedImage = selectedImage
            self.name = name
        }
        
        func save() {
            Task {
                guard let imageData = try await pickerItem?.loadTransferable(type: Data.self) else {
                    return
                }
                
                let newFriend = Friend(imageData: imageData, name: name)
                friends.append(newFriend)
                
                let savePath = URL.documentsDirectory.appending(path: "Friends")

                do {
                    let data = try JSONEncoder().encode(friends)
                    try data.write(to: savePath, options: [.atomic, .completeFileProtection])
                } catch {
                    print("Unable to save data")
                }
            }
        }
    }
}
