//
//  ContentView.swift
//  BetterRest
//
//  Created by Igor L on 09/11/2023.
//

import CoreML
import SwiftUI

struct ContentView: View {
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus"), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var showAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Challenge 1
                Section {
                    DatePicker("\(Image(systemName: "alarm.fill"))", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .foregroundColor(.black)
                        .accentColor(.gray).colorInvert()
                } header: {
                    Text("When do you want to wake up?")
                        .foregroundColor(.white)
                        .padding(.top)
                }
                .listRowBackground(Color.secondary)
                .headerProminence(.increased)
                
                Section {
                    Stepper("\(Image(systemName: "bed.double.fill")) \(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...15, step: 0.25)
                        .accentColor(.gray)
                        .foregroundColor(.white)
                } header: {
                    Text("Desired amount of sleep")
                }
                .listRowBackground(Color.secondary)
                .headerProminence(.increased)
                
                Section {
                    // Challenge 2
                    Picker("\(Image(systemName: "mug.fill")) Amount: ", selection: $coffeeAmount) {
                        ForEach(0..<21) {
                            Text("^[\($0) cup](inflect: true)")
                        }
                    }
                    .colorMultiply(.black).colorInvert()
                } header: {
                    Text("Daily coffee intake")
                        .foregroundColor(.white)
                }
                .listRowBackground(Color.secondary)
                .headerProminence(.increased)
                
                // Challenge 3
                Section {
                    VStack {
                        Text("Recommended Bedtime")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("\(Image(systemName: "moon.stars"))")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.bottom)
                        Text(calculateBedtime())
                            .font(.title3)
                            .monospaced()
                    }
                }
                .listRowBackground(Color.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets(top: 20, leading: 50, bottom: 30, trailing: 50))
            }
            .navigationTitle("BetterRest")
            .foregroundColor(.white)
            .background(
                LinearGradient(stops: [
                    Gradient.Stop(color: .yellow, location: -0.42),
                    Gradient.Stop(color: .black, location: 0.09),
                    Gradient.Stop(color: .blue, location: 2.5)
                ], startPoint: .top, endPoint: .bottom)
            )
            .scrollContentBackground(.hidden)
        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            // turn hour into seconds
            let hour = (components.hour ?? 0) * 60 * 60
            // turn minute into seconds
            let minute = (components.minute ?? 0) * 60
            
            // give time in seconds how much sleep they need
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            // Give bedtime
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "ERROR"
        }
    }
}

/*
struct ContentView: View {
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus"), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var showAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                /*
                 Original styling with vstacks
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("When do you want to wake up?", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                .listRowBackground(Color.yellow)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    //Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 0...20)
                    Picker("Coffees drank", selection: $coffeeAmount) {
                        ForEach(0..<21) {
                            Text("^[\($0) cup](inflect: true)")
                        }
                    }
                }
                .listRowBackground(Color.yellow)
                
                Section {
                    VStack {
                        Text("Recommended bedtime")
                        Text(calculateBedTime())
                    }
                }
                .listRowBackground(Color.yellow)
                 */
                
                // Challenge 1
                 Section {
                     DatePicker("When do you want to wake up?", selection: $wakeUp, displayedComponents: .hourAndMinute)
                         .accentColor(.gray)
                         .colorInvert()
                         .labelsHidden()
                 } header: {
                     Text("When do you want to wake up?")
                         .foregroundColor(.white)
                         .padding(.top)
                 }
                 .listRowBackground(Color.secondary)
                 .headerProminence(.increased)
                 
                 Section {
                     Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                         .accentColor(.gray)
                         .foregroundColor(.white)
                 } header: {
                     Text("Desired amount of sleep")
                 }
                 .listRowBackground(Color.secondary)
                 .headerProminence(.increased)
                 
                 Section {
                     // Challenge 2
                     Picker("Amount:", selection: $coffeeAmount) {
                         ForEach(0..<21) {
                             Text("^[\($0) cup](inflect: true)")
                         }
                     }
                     .colorMultiply(.black).colorInvert()
                 } header: {
                     Text("Daily coffee intake")
                         .foregroundColor(.white)
                 }
                 .listRowBackground(Color.secondary)
                 .headerProminence(.increased)
                
                // Challenge 3
                Section {
                    VStack {
                        Text("Recommended bedtime")
                            .font(.title2)
                            .weight(.bold)
                            .padding(.bottom)
                        Text(calculateBedTime())
                            .font(.title3)
                            .monospaced()
                    }
                }
                .listRowBackground(Color.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets(top: 50, leading: 50, bottom: 50, trailing: 50))
            }
            .navigationTitle("BetterRest")
            .foregroundColor(.white)
            .background(
                LinearGradient(stops: [
                    Gradient.Stop(color: .yellow, location: -0.42),
                    Gradient.Stop(color: .black, location: 0.09),
                    Gradient.Stop(color: .blue, location: 2.5)
                ], startPoint: .top, endPoint: .bottom)
            )
            .scrollContentBackground(.hidden)
            
            /*
             .toolbar {
             Button("Calculate", action: calculateBedTime)
             }
             */
            
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK") {}
            } message: {
                Text(alertMsg)
            }
        }
    }
    
    
    func calculateBedTime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            // turn hour into seconds
            let hour = (components.hour ?? 0) * 60 * 60
            // turn minute into seconds
            let minute = (components.minute ?? 0) * 60
            
            // give time in seconds how much sleep they need
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            // Give bedtime
            let sleepTime = wakeUp - prediction.actualSleep
            
            //alertTitle = "Your ideal bedtime is"
            //alertMsg = sleepTime.formatted(date: .omitted, time: .shortened)
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            //alertTitle = "ERROR"
            //alertMsg = "Sorry, there was an error in calculating"
            
            return "ERROR"
        }
        //showAlert = true
    }
}
*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
