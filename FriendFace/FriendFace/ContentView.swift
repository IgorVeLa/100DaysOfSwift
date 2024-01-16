//
//  ContentView.swift
//  FriendFace
//
//  Created by Igor L on 13/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack {
            List(users, id: \.id) { user in
                NavigationLink(value: user) {
                    HStack {
                        Text(user.name)
                        
                        Spacer()
                        
                        VStack {
                            Text("Is active:")
                                .foregroundStyle(user.isActive ? .primary : .tertiary)
                            
                            Text(user.isActive ? Image(systemName: "shareplay") : Image(systemName: "shareplay.slash"))
                        }
                    }
                }
                .navigationDestination(for: User.self) { user in
                    UserDetailView(user: user)
                }
            }
            .navigationTitle("FriendFace")
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        // Exit if users array is empty
        print(users.isEmpty)
        guard users.isEmpty else { return }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            print("Downloading...")
            let (data, _) = try await URLSession.shared.data(from: url)
                
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
