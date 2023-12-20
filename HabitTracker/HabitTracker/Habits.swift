//
//  Habits.swift
//  HabitTracker
//
//  Created by Igor L on 18/12/2023.
//

/*
 Struct
    Title - name of habit
    Description - description of habit
    Counter - how many times habit has been done
 */

import SwiftUI
import Foundation



struct HabitItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var counter = 0
}


@Observable
class Habits {
    var habitsList = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(habitsList) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedHabits) {
                habitsList = decodedItems
                return
            }
        }

        habitsList = []
    }
    
    func increment(habitItemID: UUID) {
        guard let index = getHabitIndex(habitItemID: habitItemID) else {
            print("ERROR")
            return
        }
        
        self.habitsList[index].counter = self.habitsList[index].counter + 1
    }
    
    func decrement(habitItemID: UUID) {
        guard let index = getHabitIndex(habitItemID: habitItemID) else {
            print("ERROR")
            return
        }
        
        if self.habitsList[index].counter == 0 {
            self.habitsList[index].counter = 0
        } else {
            self.habitsList[index].counter = self.habitsList[index].counter - 1
        }
        
    }
    
    func getHabit(habitItemID: UUID) -> HabitItem {
        guard let index = getHabitIndex(habitItemID: habitItemID) else {
            return HabitItem(title: "", description: "")
        }

        return habitsList[index]
    }
    
    func getHabitIndex(habitItemID: UUID) -> Int? {
        return habitsList.firstIndex(where: { $0.id == habitItemID })
    }
}

extension Habits: Hashable {
    static func == (lhs: Habits, rhs: Habits) -> Bool {
        return lhs.habitsList == rhs.habitsList
    }


    func hash(into hasher: inout Hasher) {
        hasher.combine(habitsList)
    }
}
