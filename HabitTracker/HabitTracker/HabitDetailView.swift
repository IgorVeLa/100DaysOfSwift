//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Igor L on 19/12/2023.
//

/*
 Show
    Habit name
    Habit description
    Counter to increase habit count
 */

import SwiftUI
import Foundation

struct HabitDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var habits: Habits
    var id: UUID
    
    var habit: HabitItem {
        habits.getHabit(habitItemID: id)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                VStack {
                    Text(habit.title)
                        .font(.largeTitle)
                    Text(habit.description)
                        .font(.title3)
                }
                .frame(maxWidth: .infinity)
                .listRowSeparator(.hidden)
                
                HStack {
                    Stepper(
                        onIncrement: { habits.increment(habitItemID: id) },
                        onDecrement: { habits.decrement(habitItemID: id) },
                        label: {
                            Text("Times completed: \(habit.counter)")
                                .font(.callout)
                        })
                }
            }
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    let habits = Habits()
    let habit = HabitItem(title: "Walk", description: "Minimum 10 mins")
    habits.habitsList.append(habit)
    
    return HabitDetailView(habits: habits, id: habit.id)
}
