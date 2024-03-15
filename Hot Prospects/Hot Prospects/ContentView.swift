//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Igor L on 05/03/2024.
//

import SamplePackage
import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var sortOrder = SortDescriptor(\Prospect.name)
    
    var body: some View {
        Menu("Sort") {
            Picker("Sort", selection: $sortOrder) {
                Text("Name")
                    .tag(SortDescriptor(\Prospect.name))

                Text("Most recent")
                    .tag(SortDescriptor(\Prospect.created, order: .reverse))
            }
            .pickerStyle(.inline)
        }
        
        TabView {
            ProspectsView(filter: .none, sortOrder: sortOrder)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted, sortOrder: sortOrder)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted, sortOrder: sortOrder)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    let prospect1 = Prospect(name: "Paul Hudson", emailAddress: "PaulHudson\n@hackingwithswift.com", isContacted: false)
    return ContentView()
}
