//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Igor L on 09/01/2024.
//

import Foundation
import SwiftData
import SwiftUI


struct EditUserView: View {
    @Bindable var user: User
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let testUser = User(name: "Harry Potter", city: "Staircase", joinDate: .now)
        
        return EditUserView(user: testUser)
            .modelContainer(container)
    } catch {
        return Text("\(error.localizedDescription)")
    }
}
