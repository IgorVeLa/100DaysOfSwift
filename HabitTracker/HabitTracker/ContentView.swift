//
//  ContentView.swift
//  HabitTracker
//
//  Created by Igor L on 18/12/2023.
//

/*
 List of all activities they want to track,
 Form to add new activities
    - a title and description should be enough
 Tapping one of the activities should show a detail screen with the description
 Use Codable and UserDefaults to load and save all your data
 */

import SwiftUI

struct ContentView: View {
    @State private var habits = Habits()
    
    @State private var showingHabitForm = false
    @State private var showingHabitDetail = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits.habitsList, id: \.self) { habit in
                    Button {
                        showingHabitDetail.toggle()
                    } label: {
                        HStack {
                            Text(habit.title)
                            
                            Spacer()
                            
                            Text("\(habit.counter)")

                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .sheet(isPresented: $showingHabitDetail, content: {
                        HabitDetailView(habits: habits, id: habit.id)
                    })
                }
                .onDelete(perform: deleteRow)
            }
            .toolbar {
                EditButton()
                
                Button("\(Image(systemName: "plus.circle"))") {
                    showingHabitForm.toggle()
                }
                .sheet(isPresented: $showingHabitForm, content: {
                    HabitFormView(habits: habits)
                })
            }
        }
    }
    
    func deleteRow(at offsets: IndexSet) {
        habits.habitsList.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
