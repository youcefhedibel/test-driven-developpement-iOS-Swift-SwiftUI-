//
//  ContentView.swift
//  TDD-example
//
//  Created by mac on 9/3/2023.
//

import SwiftUI

struct TipsCalculator: View {
    
    @State private var total: String = ""
    @State private var tipPercentage: Double = 0.2
    @State private var tip: String?
    @State private var message: String = ""
    let tipCalculator = TipCalculator()
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                TextField("Enter total", text: $total)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("totalTextField")
                
                Picker(selection: $tipPercentage) {
                    Text("10%").tag(0.1)
                    Text("20%").tag(0.2)
                    Text("30%").tag(0.3)
                    Text("40%").tag(0.4)
                    Text("50%").tag(0.5)
                } label: {
                    EmptyView()
                }.pickerStyle(.segmented)
                  .accessibilityIdentifier("tipPercentageSegmentedControl")
                
                Button {
                  
                    message = ""
                    tip = ""

                    guard let total = Double(self.total) else {
                        message = "Invalid Input"
                        return
                    }

                    do {

                       let result = try tipCalculator.calculate(total: total, tipPercentage: tipPercentage)

                        let formatter = NumberFormatter()
                        formatter.currencyCode = "DZD"
                        formatter.numberStyle = .currency
                        tip = formatter.string(from: NSNumber(value: result))

                    } catch TipCalculatorError.invalidInput {
                        message = "Invalid Input"
                    } catch {
                        message = error.localizedDescription
                    }
                    
                } label: {
                    Text("Calculate pourcentage")
                        .padding(5)
                   .accessibilityIdentifier("calculateTipButton")
                    
                }.padding(.top, 20)
                 .buttonStyle(.borderedProminent)
                
                Text(message)
                    .padding(.top, 50)
                    .accessibilityIdentifier("messageText")
                
                Spacer()
                
                Text(tip ?? "")
                    .font(.system(size: 54))
                    .accessibilityIdentifier("tipText")
                
                Spacer()
                
            .navigationTitle("Calculate Tip")
            }.padding()
        }
    }
}

struct TipsCalculator_Previews: PreviewProvider {
    static var previews: some View {
        TipsCalculator()
    }
}
