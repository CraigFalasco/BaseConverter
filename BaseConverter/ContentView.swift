//
//  ContentView.swift
//  BaseConverter
//
//  Created by Craig on 3/17/23.
//
// Convert a number in any bas (2 - 36) to any other base (2 - 36)
//

import SwiftUI

struct ContentView: View {
    
    @State var inNumber = "1"
    @State var inBase = "2"
    @State var targetBase = "10"
    @State var result = ""
    
    var body: some View {

        ZStack {
            Color.pink
                .ignoresSafeArea()
            Form {
                
                Text("CONVERT ANY BASE TO ANY BASE")
                    .font(.headline)
                
                Section(header: Text("YOUR NUMBER AND BASE")) {
                    
                    VStack (alignment: .leading){
                        Text("Number:")
                            .frame(width: .infinity, alignment: .leading)
                        
                        TextField("", text: $inNumber, prompt: Text("up to 11 digits"))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                    }
                    
                    HStack {
                        Picker("Base", selection: $inBase) {
                            ForEach(0..<Constants.baseValues.count, id: \.self) { index in
                                Text(String(Constants.baseValues[index])).tag(String(index + 2))
                            }
                        }
                    }
                    
                    HStack {
                        Picker("Target Base", selection: $targetBase) {
                            ForEach(0..<Constants.baseValues.count, id: \.self) { index in
                                Text(String(Constants.baseValues[index])).tag(String(index + 2))
                            }
                        }
                    }
                    if inNumber.isEmpty {
                        Text("")
                    }
                
                    if checkNumberLength(base: inBase, number: inNumber) {
                        if checkNumberFormat(base: inBase, number: inNumber) {
                            Button(action: {
                                result = getNewNumber(number: inNumber, base: inBase, targetBase: targetBase)
                            })
                            {
                                Text("SUBMIT")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Capsule())
                            }
                        }
                        else {
                            Text(Constants.formatErrorMsg)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.red)
                        }
                    }
                    else {
                        Text(Constants.limitErrorMsg)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                    }
                }
                
                Section(header: Text("Your new number")) {
                    Text("\(inNumber) in base \(targetBase) is:")
                        .bold()
                    Text(result.uppercased())
                        .bold()
                        .font(.title2)
                }
            }
            .padding()
            .cornerRadius(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
