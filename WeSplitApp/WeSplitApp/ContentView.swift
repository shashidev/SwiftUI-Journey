//
//  ContentView.swift
//  WeSplitApp
//
//  Created by Shashi Kumar on 30/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPrecentage = 20
    @FocusState private var amountIsFocused: Bool
    private let tipPrecentages = [10,15,20,25,0]
    
    
    var body: some View {
        
        NavigationStack {
            Form {
                
                Section("Bill Amount") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much tip do you want to leave?") {
                    
                    Picker("Tip Percentage", selection: $tipPrecentage) {
                        ForEach(tipPrecentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total Amount") {
                    
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused.toggle()
                    }
                }
            }
        }
        
        var totalPerPerson: Double {
            let peopleCount = Double(numberOfPeople + 2)
            let tipSelection = Double(tipPrecentage)

            let tipValue = checkAmount / 100 * tipSelection
            let grandTotal = checkAmount + tipValue
            let amountPerPerson = grandTotal / peopleCount

            return amountPerPerson
        }
        
        var totalAmount: Double {
            let tipSelection = Double(tipPrecentage)
            let tipValue = checkAmount / 100 * tipSelection
            return checkAmount + tipValue
        }
    }
    
    
}

#Preview {
    ContentView()
}

