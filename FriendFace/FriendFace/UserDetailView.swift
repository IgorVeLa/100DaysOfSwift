//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Igor L on 16/01/2024.
//

import Foundation
import SwiftUI

struct UserDetailView: View {
    var user: User
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(user.isActive ? Image(systemName: "shareplay") : Image(systemName: "shareplay.slash"))
                        .font(.title)
                    
                    Text(user.name)
                        .font(.title)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                
                VStack(alignment: .leading) {
                    Text(String(user.age))
                    
                    Text(user.company)
                    Text(user.email)
                    Text(user.address)
                    Text(user.about)
                    HStack {
                        Text("Registered on:")
                        
                        Text(user.registered, style: .date)
                    }

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    Text("Friends")
                    ScrollView() {
                        ForEach(user.friends) {
                            Text($0.name)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 30)
                }
                .padding()
                
                VStack{
                    Text("Tags")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(user.tags, id:\.self) {
                                Text($0)
                            }
                        }
                    }
                }
                .padding()
            }
            .padding(.leading)
        }
    }
}

#Preview {
    let friend1 = Friend(id: UUID(),
                         name: "Ely Medina")
    let friend2 = Friend(id: UUID(),
                         name: "Juancho Aguila")
    let friend3 = Friend(id: UUID(),
                         name: "Kenz Caduhada")
    
    return UserDetailView(user: User(id: UUID(),
                              isActive: true,
                              name: "Kyle Isidro",
                              age: 22,
                              company: "Nintendo",
                              email: "ksbroksi@hotmail.com",
                              address: "1 Bykerton Land",
                              about: "I am a mister doctor man", registered: Date.now,
                              tags: ["cillum", "consequat", "deserunt", "nostrud", "eiusmod", "minim", "tempor"],
                              friends: [friend1, friend2, friend3]))
}
