//
//  ClassNumber.swift
//  BaseConverter
//
//  Created by Craig on 3/17/23.
//

import Foundation

// number of digits limit for bases used in checkNumberLength
//  2 -  4 = 28 digits
//       5 = 27
//       6 = 24
//       7 = 22
//       8 = 21
//       9 = 19
// 10 - 11 = 18
// 12 - 13 = 17
//    - 14 = 16
// 15 - 18 = 15
// 19 - 22 = 14
// 23 - 28 = 13
// 29 - 36 = 12

func checkNumberLength (base: String, number: String) -> Bool {
    
    let intBase = Int(base) ?? 2
    
    switch intBase {
        
    case 2...4:
        if number.count > 28 {
            Constants.limitErrorMsg = "Base \(base) limit is 28 digits"
            return false
        }
    case 5:
        if number.count > 27 {
            Constants.limitErrorMsg = "Base \(base) limit is 27 digits"
            return false
        }
    case 6:
        if number.count > 24 {
            Constants.limitErrorMsg = "Base \(base) limit is 24 digits"
            return false
        }
    case 7:
        if number.count > 22 {
            Constants.limitErrorMsg = "Base \(base) limit is 22 digits"
            return false
        }
    case 8:
        if number.count > 21 {
            Constants.limitErrorMsg = "Base \(base) limit is 21 digits"
            return false
        }
    case 9:
        if number.count > 19 {
            Constants.limitErrorMsg = "Base \(base) limit is 19 digits"
            return false
        }
    case 10...11:
        if number.count > 18 {
            Constants.limitErrorMsg = "Base \(base) limit is 18 digits"
            return false
        }
    case 12...13:
        if number.count > 17 {
            Constants.limitErrorMsg = "Base \(base) limit is 17 digits"
            return false
        }
    case 14:
        if number.count > 16 {
            Constants.limitErrorMsg = "Base \(base) limit is 16 digits"
            return false
        }
    case 15...18:
        if number.count > 15 {
            Constants.limitErrorMsg = "Base \(base) limit is 15 digits"
            return false
        }
    case 19...22:
        if number.count > 14 {
            Constants.limitErrorMsg = "Base \(base) limit is 14 digits"
            return false
        }
    case 23...28:
        if number.count > 13 {
            Constants.limitErrorMsg = "Base \(base) limit is 13 digits"
            return false
        }
    case 29...36:
        if number.count > 12 {
            Constants.limitErrorMsg = "Base \(base) limit is 12 digits"
            return false
        }
    default:
        Constants.limitErrorMsg = ""
        return false
    }
    return true
}

func checkNumberFormat(base: String, number: String) -> Bool{
    
    // create an array with just the valid place values for the input number, to be used to validate the input
    let validPlaceValues = createValidPlaceValueArray(base: base)

    // use the previous array to check each digit of input to make sure it is using valid digits for its base
    let inputNumArray = Array(number.lowercased())
    var i = 0
    while i < inputNumArray.count {
        if validPlaceValues.contains(String(inputNumArray[i])) {
            i += 1
        }
        else {
            Constants.formatErrorMsg = "Invalid character for base \(base)"
            return false
        }
    }
    return true
}

func getNewNumber(number: String, base: String, targetBase: String) -> String {
    
    var result = ""
    
    if base == "10" {
        result = convertBaseTenToOther(inNum: number, targetBase: targetBase)
    }
    else if targetBase == "10" {
        result = convertOtherToBaseTen(inNum: number, inBase: base)
    }
    else {
        // when from and to bases are not 10, first convert to ten, then convert that temp result to the target base
        let tempResult = convertOtherToBaseTen(inNum: number, inBase: base)
        result = convertBaseTenToOther(inNum: tempResult, targetBase: targetBase)
    }
    return result
}

func convertBaseTenToOther(inNum: String, targetBase: String) -> String {
    
    let intNum = Int(inNum) ?? 1
    let intBase = Int(targetBase) ?? 10
    var newNumber = [String]()
    let divisor = intBase
    var dividend = intNum
    var quotient = 0
    var remainder = 0
    
    while (divisor <= dividend) {
        remainder = dividend % divisor
        quotient = dividend / divisor
        newNumber.append(Constants.basePlaceValues[remainder])
        dividend = quotient
    }
    
    newNumber.append(Constants.basePlaceValues[dividend])
    newNumber.reverse()
    
    return newNumber.joined()
}

func convertOtherToBaseTen(inNum: String, inBase: String) -> String {
    
    
    // create an array with just the valid place values for the input base, to be used to convert the base place values to decimal numbers
    let newPlaceValues = createValidPlaceValueArray(base: String(inBase))
    
    // Create array with each digit of the input number converted to decimal. Example: hex abc becomes [10, 11, 12]
    let inputNumArray = Array(inNum.lowercased())
    var inputNumConverted = [Int]()
    var b = 0
    
    while b < inputNumArray.count {
        if let index = newPlaceValues.firstIndex(of: String(inputNumArray[b])) {
            inputNumConverted.append(index)
        }
        b += 1
    }
    
    // the new base number is the sum of each converted digit[c] times the (base raised to the power of p), from right to left, or low order to high order
    var c = inputNumConverted.count - 1
    var p = 0
    var result = 0
    let intBase = Int(inBase) ?? 1
   
    while c >= 0 {
        result = result + (inputNumConverted[c] * Int(pow(Double(intBase),Double(p))))
        c -= 1
        p += 1
    }
    return String(result)
}

func createValidPlaceValueArray (base: String) -> [String] {
    
    // create an array with just the valid place values for the input base
    var returnPlaceValues = [String]()
    var d = 0
    
    while d < Int(base)! {
        returnPlaceValues.append(Constants.basePlaceValues[d])
        d += 1
    }
    return returnPlaceValues
}

