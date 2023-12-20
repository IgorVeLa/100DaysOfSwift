//
//  HabitFormView.swift
//  HabitTracker
//
//  Created by Igor L on 18/12/2023.
//

/*
 Form for user to add
    Habit name
    Habit description
 */

import SwiftUI
import Foundation

struct HabitFormView: View {
    @Environment(\.dismiss) var dismiss
    
    var habits: Habits
    
    @State private var habitTitle = ""
    @State private var habitDescription = ""
    
    var body: some View {
        NavigationStack {
            Form {
                VStack {
                    TextField("Select a name for habit", text: $habitTitle)
                    TextField("Write a description", text: $habitDescription)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save", action: save)
                    }
                }
            }
        }
    }
    
    func save() {
        let habit = HabitItem(title: habitTitle,
                              description: habitDescription)
        habits.habitsList.append(habit)
        
        dismiss()
    }
}

#Preview {
    let habits = Habits()
    let habit = HabitItem(title: "Walk", description: "Minimum 10 mins")
    habits.habitsList.append(habit)
    
    return HabitFormView(habits: habits)
}
