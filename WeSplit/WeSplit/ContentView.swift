//
//  ContentView.swift
//  WeSplit
//
//  Created by Igor L on 26/09/2023.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [0, 10, 15, 20, 25]
    
    // Bonus challenge
    var localCurrencyCode: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "GBP")
    
    var totalCalculations: [Double] {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return [tipValue, grandTotal, amountPerPerson]
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount: ", value: $checkAmount, format: localCurrencyCode).keyboardType(.decimalPad).focused($amountIsFocused)
                              
                    Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2 ..< 100) {
                                Text("\($0) people")
                            }
                    }
                }
                .pickerStyle(.navigationLink)
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        // Challenge 3
                        ForEach(0 ..< 101) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                // Challenge 2
                Section {
                    Text("Tip value: \(totalCalculations[0])")
                    Text("Grand Total: \(totalCalculations[1])")
                    Text(totalCalculations[2], format: localCurrencyCode)
                } header: {
                    // Challenge 1
                    Text("Amount for each person: ")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
