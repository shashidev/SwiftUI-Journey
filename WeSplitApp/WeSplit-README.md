# SwiftUI WeSplit App Tutorial

## Introduction
This tutorial walks you through creating a simple tip calculator app using SwiftUI. The app takes a bill amount, allows users to select a tip percentage, and calculates both the total amount and the amount each person needs to pay.

## Code Breakdown

### Importing SwiftUI
We start by importing SwiftUI, which provides the necessary UI components for building the app.
```swift
import SwiftUI
```

### Defining the ContentView Structure
The `ContentView` struct is the main view of our app. It includes several state variables and UI elements.

#### State Variables
```swift
@State private var checkAmount = 0.0
@State private var numberOfPeople = 2
@State private var tipPrecentage = 20
@FocusState private var amountIsFocused: Bool
private let tipPrecentages = [10, 15, 20, 25, 0]
```
- `checkAmount`: Stores the bill amount entered by the user.
- `numberOfPeople`: Holds the number of people sharing the bill.
- `tipPrecentage`: Stores the selected tip percentage.
- `amountIsFocused`: A `FocusState` property to manage keyboard focus.
- `tipPrecentages`: An array of tip percentages to choose from.

### Building the UI with SwiftUI

#### NavigationStack and Form
The UI is built using `NavigationStack` and `Form` for better organization.
```swift
NavigationStack {
    Form {
```

#### Input Fields
- The bill amount is entered using `TextField`.
```swift
Section("Bill Amount") {
    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        .keyboardType(.decimalPad)
        .focused($amountIsFocused)
}
```

- A `Picker` allows users to select the number of people.
```swift
Section {
    Picker("Number of people", selection: $numberOfPeople) {
        ForEach(2..<100) {
            Text("\($0) people")
        }
    }
}
```

- Another `Picker` lets users select a tip percentage.
```swift
Section("How much tip do you want to leave?") {
    Picker("Tip Percentage", selection: $tipPrecentage) {
        ForEach(tipPrecentages, id: \.self) {
            Text($0, format: .percent)
        }
    }
    .pickerStyle(.segmented)
}
```

#### Displaying Results
- Total amount including tip:
```swift
Section("Total Amount") {
    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
}
```

- Amount per person:
```swift
Section("Amount per person") {
    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
}
```

#### Dismissing the Keyboard
A `toolbar` button allows users to dismiss the keyboard.
```swift
.toolbar {
    if amountIsFocused {
        Button("Done") {
            amountIsFocused.toggle()
        }
    }
}
```

### Calculating Totals
- `totalPerPerson`: Computes the amount each person pays.
```swift
var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPrecentage)
    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount
    return amountPerPerson
}
```

- `totalAmount`: Computes the total bill including tip.
```swift
var totalAmount: Double {
    let tipSelection = Double(tipPrecentage)
    let tipValue = checkAmount / 100 * tipSelection
    return checkAmount + tipValue
}
```

### Previewing the View
The `#Preview` macro enables SwiftUI previews in Xcode.
```swift
#Preview {
    ContentView()
}
```

## Conclusion
This SwiftUI tutorial covers the basics of building a tip calculator using `NavigationStack`, `Form`, `TextField`, `Picker`, and computed properties for calculations. You can further enhance this app by adding animations or additional styling.

