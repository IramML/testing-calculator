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
    
    func makeOperation(firstNumber: Double, secondNumber: Double, operation: MathOperation) {
        let result: Double
        switch operation {
        case .addition:
            result = self.arithmeticOperations.addition(firstNumber: firstNumber, secondNumber: secondNumber)
        case .division:
            result = self.arithmeticOperations.division(firstNumber: firstNumber, secondNumber: secondNumber).doubleValue
        case .multiplication:
            result = self.arithmeticOperations.multiplication(firstNumber: firstNumber, secondNumber: secondNumber)
        case .substraction:
            result = self.arithmeticOperations.substraction(firstNumber: firstNumber, secondNumber: secondNumber)
        }
        
        presenter?.showResult(result)
    }
}
