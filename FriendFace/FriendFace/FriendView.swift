//
//  FriendView.swift
//  FriendFace
//
//  Created by Igor L on 17/02/2024.
//

import Foundation
import PhotosUI
import SwiftUI

struct FriendView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: ViewModel
    
    init(friends: [Friend]) {
        _viewModel = State(initialValue: ViewModel(friends: friends))
    }
    
    var body: some View {
        VStack {
            viewModel.selectedImage?
                .resizable()
                .scaledToFit()
            
            if viewModel.selectedImage != nil {
                TextField("Name", text: $viewModel.name)
                    .multilineTextAlignment(.center)
                
                Button("Save") {
                    viewModel.save()
                    dismiss()
                }
                .disabled(viewModel.name.isEmpty)
            } else {
                PhotosPicker(selection: $viewModel.pickerItem) {
                    ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                }
                .onChange(of: viewModel.pickerItem) {
                    Task {
                        // load underlying data from pickerItem into selectedImage
                        viewModel.selectedImage = try await viewModel.pickerItem?.loadTransferable(type: Image.self)
                    }
                }
            }
        }
    }
}

//#Preview {
//    //FriendView(friends: .constant([Friend]()))
//    FriendView()
//}
