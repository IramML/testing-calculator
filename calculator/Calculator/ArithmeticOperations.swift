//
//  ArithmeticOperations.swift
//  calculator
//
//  Created by Iram Martinez on 17/08/22.
//

import Foundation


class ArithmeticOperations {
    func addition<T: Numeric>(firstNumber: T, secondNumber: T) -> T {
        return firstNumber + secondNumber
    }
    
    func substraction<T: Numeric>(firstNumber: T, secondNumber: T) -> T {
        return firstNumber - secondNumber
    }
    
    func division<T: Numeric>(firstNumber: T, secondNumber: T) -> NSDecimalNumber {
        guard let firstNumber = (try? Decimal("\(firstNumber)", format: .number)),
              let secondNumber = (try? Decimal("\(secondNumber)", format: .number)) else {
            return NSDecimalNumber.notANumber
        }
        return NSDecimalNumber(decimal: firstNumber / secondNumber)
    }
    
    func multiplication<T: Numeric>(firstNumber: T, secondNumber: T) -> T {
        return firstNumber * secondNumber
    }
}
