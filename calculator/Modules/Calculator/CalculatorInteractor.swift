//
//  CalculatorInteractor.swift
//  calculator
//
//  Created by Iram Martinez on 24/10/22.
//

import Foundation

class CalculatorInteractor {
    weak var presenter: CalculatorPresenter?
    
    private let arithmeticOperations = ArithmeticOperations()
    
    func makeOperation(firstNumber: Double, secondNumber: Double, operation: MathOperation) -> Double {
        switch operation {
        case .addition:
            return self.arithmeticOperations.addition(firstNumber: firstNumber, secondNumber: secondNumber)
        case .division:
            return self.arithmeticOperations.division(firstNumber: firstNumber, secondNumber: secondNumber).doubleValue
        case .multiplication:
            return self.arithmeticOperations.multiplication(firstNumber: firstNumber, secondNumber: secondNumber)
        case .substraction:
            return self.arithmeticOperations.substraction(firstNumber: firstNumber, secondNumber: secondNumber)
        }
    }
}
