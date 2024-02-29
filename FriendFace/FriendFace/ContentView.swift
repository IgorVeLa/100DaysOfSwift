//
//  ContentView.swift
//  FriendFace
//
//  Created by Igor L on 15/02/2024.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            if viewModel.friends.isEmpty {
                Button {
                    viewModel.showingFriendView.toggle()
                } label: {
                    ContentUnavailableView("No friends added", systemImage: "person.crop.circle.badge.exclamationmark", description: Text("Tap to add"))
                }
                .sheet(isPresented: $viewModel.showingFriendView) {
                    FriendView(friends: $viewModel.friends.wrappedValue)
                }
                .navigationTitle("FriendFace")
            } else {
                List {
                    ForEach(viewModel.friends.sorted(), id:\.self) { friend in
                        NavigationLink(value: friend) {
                            VStack {
                                Spacer()
                                friend.image
                                    .resizable()
                                    .scaledToFit()
                                Text(friend.name)
                                Spacer()
                            }
                        }
                        .navigationDestination(for: Friend.self) { friend in
                            ImageView(friend: friend)
                        }
                    }
                    
                }
                .navigationTitle("FriendFace")
                .toolbar {
                    Button("Add") {
                        viewModel.showingFriendView.toggle()
                    }
                    .sheet(isPresented: $viewModel.showingFriendView) {
                        FriendView(friends: $viewModel.friends.wrappedValue)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
