//
//  calculatorPresenterTests.swift
//  calculatorTests
//
//  Created by Iram Martinez on 20/08/22.
//

import XCTest
@testable import calculator

class calculatorPresenterTests: XCTestCase {
    let calculatorView: CalculatorView = CalculatorView()

    override func tearDownWithError() throws {
        self.calculatorView.deleteAll()
        
    }
    
    func test_noAction() {
        XCTAssertEqual(calculatorView.displayContent, "")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_addFirstNumber() {
        calculatorView.enterNumber(1)
        XCTAssertEqual(calculatorView.displayContent, "1")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_addFirstNumberEnterTwoDigits() {
        calculatorView.enterNumber(1)
        calculatorView.enterNumber(2)
        XCTAssertEqual(calculatorView.displayContent, "12")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_deleteAllAfterEnterNumber() {
        calculatorView.enterNumber(1)
        calculatorView.deleteAll()
        
        XCTAssertEqual(calculatorView.displayContent, "")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_enterOperationWithoutEnterFirstNumber() {
        calculatorView.enterOperation(.addition)
        
        XCTAssertEqual(calculatorView.displayContent, "")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_enterOperationAfterEnterFirstNumber() {
        calculatorView.enterNumber(1)
        calculatorView.enterOperation(.addition)
        
        XCTAssertEqual(calculatorView.displayContent, MathOperation.addition.description)
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterOperation)
    }
    
    func test_enterTwoOperationAfterEnterFirstNumber_shouldUseLastOperation() {
        calculatorView.enterNumber(1)
        calculatorView.enterOperation(.addition)
        calculatorView.enterOperation(.multiplication)
        
        XCTAssertEqual(calculatorView.displayContent, MathOperation.multiplication.description)
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterOperation)
    }

    func test_enterSecondNumberAfterFirstNumberAndOperation() {
        calculatorView.enterNumber(1)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(2)
        
        XCTAssertEqual(calculatorView.displayContent, "2")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterSecondNumber)
    }
    
    func test_enterSecondNumberWithTwoDigitsAfterFirstNumberAndOperation() {
        calculatorView.enterNumber(1)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(2)
        calculatorView.enterNumber(5)
        
        XCTAssertEqual(calculatorView.displayContent, "25")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterSecondNumber)
    }
    
    func test_computeAdditionBetweenTwoNumbers() {
        calculatorView.enterNumber(3)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(5)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "8.0")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeMultiplicationBetweenTwoNumbers() {
        calculatorView.enterNumber(6)
        calculatorView.enterOperation(.multiplication)
        calculatorView.enterNumber(2)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "12.0")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeDivisionBetweenTwoNumbers() {
        calculatorView.enterNumber(16)
        calculatorView.enterOperation(.division)
        calculatorView.enterNumber(4)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "4.0")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeDivisionBetweenAnyNumberAndZero() {
        calculatorView.enterNumber(5)
        calculatorView.enterOperation(.division)
        calculatorView.enterNumber(0)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "No puedes dividir entre 0")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeSubstractionBetweenTwoNumbers() {
        calculatorView.enterNumber(8)
        calculatorView.enterOperation(.substraction)
        calculatorView.enterNumber(7)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "1.0")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeAdditionBetweenTwoNumbersWithTwoDigits() {
        calculatorView.enterNumber(1)
        calculatorView.enterNumber(1)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(2)
        calculatorView.enterNumber(2)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "33.0")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeAdditionBetweenTwoFloatNumbers() {
        calculatorView.enterNumber(1)
        calculatorView.enterDot()
        calculatorView.enterNumber(1)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(2)
        calculatorView.enterDot()
        calculatorView.enterNumber(1)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "3.2")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_numbersJustEnterOnlyOneValidDot() {
        calculatorView.enterNumber(5)
        XCTAssertEqual(calculatorView.displayContent, "5")
        calculatorView.enterDot()
        XCTAssertEqual(calculatorView.displayContent, "5.")
        calculatorView.enterNumber(1)
        XCTAssertEqual(calculatorView.displayContent, "5.1")
        calculatorView.enterDot()
        XCTAssertEqual(calculatorView.displayContent, "5.1")
        calculatorView.enterNumber(1)
        XCTAssertEqual(calculatorView.displayContent, "5.11")
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(4)
        XCTAssertEqual(calculatorView.displayContent, "4")
        calculatorView.enterDot()
        XCTAssertEqual(calculatorView.displayContent, "4.")
        calculatorView.enterNumber(1)
        XCTAssertEqual(calculatorView.displayContent, "4.1")
        calculatorView.enterDot()
        XCTAssertEqual(calculatorView.displayContent, "4.1")
        calculatorView.enterNumber(1)
        XCTAssertEqual(calculatorView.displayContent, "4.11")
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "9.22")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_enterNumbersStartingWithDot() {
        calculatorView.enterDot()
        calculatorView.enterNumber(1)
        XCTAssertEqual(calculatorView.displayContent, ".1")
        calculatorView.enterOperation(.addition)
        XCTAssertEqual(calculatorView.displayContent, MathOperation.addition.description)
        calculatorView.enterDot()
        calculatorView.enterNumber(5)
        XCTAssertEqual(calculatorView.displayContent, ".5")
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "0.6")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeResultWithNoNumbers() {
        calculatorView.computeResultOperation()
        XCTAssertEqual(calculatorView.displayContent, "")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_enterNumberAfterResult_shouldEnterFirstNumber() {
        calculatorView.enterNumber(3)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(5)
        calculatorView.computeResultOperation()
        calculatorView.enterNumber(9)
        
        XCTAssertEqual(calculatorView.displayContent, "9")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_enterDotNumberAfterResult_shouldEnterFirstNumber() {
        calculatorView.enterNumber(3)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(5)
        calculatorView.computeResultOperation()
        calculatorView.enterDot()
        calculatorView.enterNumber(2)
        
        XCTAssertEqual(calculatorView.displayContent, ".2")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
}

class CalculatorView {
    var displayContent: String = ""
    let calculatorPresenter: CalculatorPresenter = CalculatorPresenter()
    
    init() {
        self.calculatorPresenter.delegate = self
    }
    
    func enterNumber(_ number: Int) {
        self.calculatorPresenter.numberSelected(number)
    }
    
    func enterOperation(_ operation: MathOperation) {
        self.calculatorPresenter.operationSelected(operation)
    }
    
    func computeResultOperation() {
        self.calculatorPresenter.computeResult()
    }
    
    func enterDot() {
        self.calculatorPresenter.enterDot()
    }
    
    func deleteAll() {
        self.calculatorPresenter.deleteAll()
    }
}

extension CalculatorView: CalculatorDelegate {
    func showOnCalculatorDisplay(_ content: String) {
        displayContent = content
    }
}
