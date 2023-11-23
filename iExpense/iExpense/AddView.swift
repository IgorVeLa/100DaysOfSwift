//
//  AddView.swift
//  iExpense
//
//  Created by Igor L on 21/11/2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var value = ""

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "GBP"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    // Challenge 2
                    if amount < 10 {
                        value = "low"
                    } else if amount < 100 {
                        value = "mid"
                    } else {
                        value = "high"
                    }
                    
                    let item = ExpenseItem(name: name,
                                           type: type,
                                           amount: amount,
                                           value: value)
                    expenses.items.append(item)
                    
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
