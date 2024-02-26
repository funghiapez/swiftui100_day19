//
//  ContentView.swift
//  LengthConvert
//
//  Created by FunghiApe on 2024/2/26.
//

import SwiftUI

struct ContentView: View {
    @State private var val1: Double = 0.0
    @State private var val2: Double = 0.0
    @State private var unit1: String = "m"
    @State private var unit2: String = "in"
    
    @FocusState private var val1IsFocused: Bool
    @FocusState private var val2IsFocused: Bool
    
    private let metricUnits: [String] = ["m", "km"]
    private let usUnits: [String] = ["in", "ft", "mi"]
    private var units: [String] { metricUnits + usUnits }
    
    
    func getResult(fromVal: Double, from: String, to: String) -> Double {
        var meterVal = 0.0
        switch from {
        case "m":
            meterVal = fromVal
            break
        case "km":
            meterVal = fromVal * 1000
            break
        case "in":
            meterVal = fromVal * 0.0254
            break
        case "ft":
            meterVal = fromVal * 0.3048
            break
        case "mi":
            meterVal = fromVal * 1609.344
            break
        default:
            meterVal = -1
        }
        switch to {
        case "m":
            return meterVal
        case "km":
            return meterVal / 1000
        case "in":
            return meterVal / 0.0254
        case "ft":
            return meterVal / 0.3048
        case "mi":
            return meterVal / 1609.344
        default:
            return -1
        }
    }
    
    var body: some View {
        NavigationView {Form{
            Section("From") {
                TextField("Value", value: $val1, format: .number).keyboardType(.decimalPad).focused($val1IsFocused)
                Picker("Unit", selection: $unit1) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                .onChange(of: unit1) {
                    val2 = getResult(fromVal: val1, from: unit1, to: unit2)
                }
            }
            Section("To") {
                TextField("Value", value: $val2, format: .number).keyboardType(.decimalPad).focused($val2IsFocused)
                Picker("Unit", selection: $unit2) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                .onChange(of: unit2) {
                    val1 = getResult(fromVal: val2, from: unit2, to: unit1)
                }
            }
        }
        .navigationTitle("LengthConvert").toolbar {
            if val1IsFocused {
                Button("Done") {
                    val1IsFocused = false
                    val2 = getResult(fromVal: val1, from: unit1, to: unit2)
                }
            }
            if val2IsFocused {
                Button("Done") {
                    val2IsFocused = false
                    val1 = getResult(fromVal: val2, from: unit2, to: unit1)
                }
            }
        }
        }
    }
}

#Preview {
    ContentView()
}
