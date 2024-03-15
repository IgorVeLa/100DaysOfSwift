//
//  EditView.swift
//  Hot Prospects
//
//  Created by Igor L on 13/03/2024.
//

import Foundation
import SwiftUI
import SwiftData

struct EditView: View {
    @Bindable var prospect: Prospect
    
    @State private var name = ""
    @State private var emailAddress = ""
    
    var body: some View {
        Form {
            TextField("name", text: $prospect.name)
            TextField("email", text: $prospect.emailAddress)
        }
        .navigationTitle("Edit Prospect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let prospect1 = Prospect(name: "John Doe", emailAddress: "JDoe@email.com", isContacted: false)
        
        return EditView(prospect: prospect1)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
