//
//  ContentView.swift
//  iExpense
//
//  Created by Igor L on 20/11/2023.
//

import SwiftUI


struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    // Challenge 2
    let value: String
}


@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    // Challenge 3
    var personalItems: [ExpenseItem] {
        items.filter { $0.type == "Personal" }
    }

    var businessItems: [ExpenseItem] {
        items.filter { $0.type == "Business" }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}


struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    // Challenge 1
    var localCurrencyCode: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "GBP")
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        ForEach(expenses.personalItems) { item in
                            expenseRowView(item.name, item.type, item.amount, item.value)
                        }
                        .onDelete(perform: removePersonalItems)
                    }
                    
                    Section {
                        ForEach(expenses.businessItems) { item in
                            expenseRowView(item.name, item.type, item.amount, item.value)
                        }
                        .onDelete(perform: removeBusinessItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense.toggle()
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    // Challenge 3
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectsToDelete = IndexSet()

        for offset in offsets {
            let item = inputArray[offset]

            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }

        expenses.items.remove(atOffsets: objectsToDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalItems)
    }

    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }
    
    // Challenge 2
    func expenseColour(value: String) -> Color {
        if value == "low" {
            return Color.green
        } else if value == "mid" {
            return Color.orange
        } else {
            return Color.red
        }
    }
    
    // Challenge 2
    @ViewBuilder
    func expenseRowView(_ name: String, _ type: String, _ amount: Double, _ value: String) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                
                Text(type)
            }
            
            Spacer()
            
            Text(amount, format: localCurrencyCode)
            // Challenge 2
                .foregroundColor(expenseColour(value: value))
        }
    }
}

#Preview {
    ContentView()
}
