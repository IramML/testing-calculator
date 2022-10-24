//
//  CalculatorViewModel.swift
//  calculator
//
//  Created by Iram Martinez on 19/08/22.
//

import Foundation

protocol CalculatorDelegate: AnyObject {
    func showOnCalculatorDisplay(_ content: String)
}

class CalculatorPresenter {
    var router: RouterProtocol?
    var interactor: CalculatorInteractor?
    weak var view: CalculatorDelegate?
    
    init() {
        
    }
    
    private(set) var status: CalculatorStatus = .enterFirstNumber
    private var lastResult: Double? = nil
    private var operationSelected: MathOperation? = nil
    private var stringNumbersToCompute: (String, String) = ("","")
    
    func numberSelected(_ number: Int) {
        switch (status) {
        case .enterFirstNumber:
            self.addDigit(number)
            self.displayToView(stringNumbersToCompute.0)
        case .enterOperation, .enterSecondNumber:
            self.addDigit(number, isFirst: false)
            self.displayToView(stringNumbersToCompute.1)
            if !(status == .enterSecondNumber) {
                self.status = .enterSecondNumber
            }
            
        case .result:
            self.deleteAll()
            self.addDigit(number)
            self.displayToView(stringNumbersToCompute.0)
        }
    }
    
    func operationSelected(_ operation: MathOperation) {
        guard (status == .enterFirstNumber && !stringNumbersToCompute.0.isEmpty) || status == .enterOperation || status == .result else {
            return
        }
        if let lastResult = lastResult, status == .result {
            self.stringNumbersToCompute.0 = String(lastResult)
        }
        self.operationSelected = operation
        self.displayToView(operation.description)
        self.status = .enterOperation
    }
    
    func computeResult() {
        guard let operationSelected = operationSelected, case .enterSecondNumber = status, !self.stringNumbersToCompute.1.isEmpty else {
            return
        }
        if let firstNumber = Double(self.stringNumbersToCompute.0), let secondNumber = Double(self.stringNumbersToCompute.1) {
            
            interactor?.makeOperation(firstNumber: firstNumber, secondNumber: secondNumber, operation: operationSelected)
        }
    }
    
    func enterDot() {
        switch (status) {
        case .enterFirstNumber:
            if !self.stringNumbersToCompute.0.contains(".") {
                self.stringNumbersToCompute.0 += "."
                self.displayToView(self.stringNumbersToCompute.0)
            }
        case .enterSecondNumber:
            if !self.stringNumbersToCompute.1.contains(".") {
                self.stringNumbersToCompute.1 += "."
                self.displayToView(self.stringNumbersToCompute.1)
            }
        case .enterOperation:
            self.stringNumbersToCompute.1 += "."
            self.status = .enterSecondNumber
            self.displayToView(self.stringNumbersToCompute.1)
        case .result:
            self.stringNumbersToCompute.0 += "."
            self.status = .enterFirstNumber
            self.displayToView(self.stringNumbersToCompute.0)
        }
    }
    
    func deleteAll() {
        self.status = .enterFirstNumber
        self.lastResult = nil
        self.stringNumbersToCompute = ("","")
        self.displayToView("")
        self.operationSelected = nil
    }
    
    private func addDigit(_ number: Int, isFirst isFirstNumber: Bool = true) {
        if isFirstNumber {
            self.stringNumbersToCompute.0 += String(number)
            return
        }
        self.stringNumbersToCompute.1 += String(number)
    }
    
    private func displayToView(_ content: String) {
        self.view?.showOnCalculatorDisplay(content)
    }
    
    func showResult(_ result: Double) {
        self.lastResult = result
        self.status = .result
        
        guard let lastResult = lastResult else {
            return
        }
        let resultToDisplay: String
        if lastResult.isNaN {
            resultToDisplay = "No puedes dividir entre 0"
        } else if String(lastResult).hasSuffix(".0") {
            resultToDisplay = String(lastResult).replacingOccurrences(of: ".0", with: "")
        } else {
            resultToDisplay = String(lastResult)
        }
        self.displayToView(resultToDisplay)
        self.stringNumbersToCompute = ("", "")
    }
}

enum CalculatorStatus {
    case enterFirstNumber, enterOperation, enterSecondNumber, result
}
extension CalculatorStatus: Equatable {}

