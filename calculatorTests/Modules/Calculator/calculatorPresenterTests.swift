//
//  calculatorPresenterTests.swift
//  calculatorTests
//
//  Created by Iram Martinez on 20/08/22.
//

import XCTest
@testable import calculator

class calculatorPresenterTests: XCTestCase {
    
    func test_noAction() {
        let calculatorView = makeSUT()
        XCTAssertEqual(calculatorView.displayContent, "")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_addFirstNumber() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(1)
        XCTAssertEqual(calculatorView.displayContent, "1")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_addFirstNumberEnterTwoDigits() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(1)
        calculatorView.enterNumber(2)
        XCTAssertEqual(calculatorView.displayContent, "12")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_deleteAllAfterEnterNumber() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(1)
        calculatorView.deleteAll()
        
        XCTAssertEqual(calculatorView.displayContent, "")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_enterOperationWithoutEnterFirstNumber() {
        let calculatorView = makeSUT()
        calculatorView.enterOperation(.addition)
        
        XCTAssertEqual(calculatorView.displayContent, "")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_enterOperationAfterEnterFirstNumber() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(1)
        calculatorView.enterOperation(.addition)
        
        XCTAssertEqual(calculatorView.displayContent, MathOperation.addition.description)
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterOperation)
    }
    
    func test_enterTwoOperationAfterEnterFirstNumber_shouldUseLastOperation() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(1)
        calculatorView.enterOperation(.addition)
        calculatorView.enterOperation(.multiplication)
        
        XCTAssertEqual(calculatorView.displayContent, MathOperation.multiplication.description)
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterOperation)
    }

    func test_enterSecondNumberAfterFirstNumberAndOperation() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(1)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(2)
        
        XCTAssertEqual(calculatorView.displayContent, "2")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterSecondNumber)
    }
    
    func test_enterSecondNumberWithTwoDigitsAfterFirstNumberAndOperation() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(1)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(2)
        calculatorView.enterNumber(5)
        
        XCTAssertEqual(calculatorView.displayContent, "25")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterSecondNumber)
    }
    
    func test_computeAdditionBetweenTwoNumbers() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(3)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(5)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "8")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeMultiplicationBetweenTwoNumbers() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(6)
        calculatorView.enterOperation(.multiplication)
        calculatorView.enterNumber(2)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "12")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeDivisionBetweenTwoNumbers() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(16)
        calculatorView.enterOperation(.division)
        calculatorView.enterNumber(4)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "4")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeDivisionBetweenAnyNumberAndZero() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(5)
        calculatorView.enterOperation(.division)
        calculatorView.enterNumber(0)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "No puedes dividir entre 0")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeSubstractionBetweenTwoNumbers() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(8)
        calculatorView.enterOperation(.substraction)
        calculatorView.enterNumber(7)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "1")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeAdditionBetweenTwoNumbersWithTwoDigits() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(1)
        calculatorView.enterNumber(1)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(2)
        calculatorView.enterNumber(2)
        calculatorView.computeResultOperation()
        
        XCTAssertEqual(calculatorView.displayContent, "33")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
    }
    
    func test_computeAdditionBetweenTwoFloatNumbers() {
        let calculatorView = makeSUT()
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
        let calculatorView = makeSUT()
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
        let calculatorView = makeSUT()
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
        let calculatorView = makeSUT()
        calculatorView.computeResultOperation()
        XCTAssertEqual(calculatorView.displayContent, "")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_enterNumberAfterResult_shouldEnterFirstNumber() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(3)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(5)
        calculatorView.computeResultOperation()
        calculatorView.enterNumber(9)
        
        XCTAssertEqual(calculatorView.displayContent, "9")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_enterDotNumberAfterResult_shouldEnterFirstNumber() {
        let calculatorView = makeSUT()
        calculatorView.enterNumber(3)
        calculatorView.enterOperation(.addition)
        calculatorView.enterNumber(5)
        calculatorView.computeResultOperation()
        calculatorView.enterDot()
        calculatorView.enterNumber(2)
        
        XCTAssertEqual(calculatorView.displayContent, ".2")
        XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterFirstNumber)
    }
    
    func test_computeOperationUsingLastResult() {
        let calculatorView = makeSUT()
          calculatorView.enterNumber(6)
          calculatorView.enterOperation(.addition)
          calculatorView.enterNumber(1)
          calculatorView.computeResultOperation()
          calculatorView.enterOperation(.addition)
          XCTAssertEqual(calculatorView.displayContent, "+")
          XCTAssertEqual(calculatorView.calculatorPresenter.status, .enterOperation)
          calculatorView.enterNumber(3)
          calculatorView.computeResultOperation()
          XCTAssertEqual(calculatorView.displayContent, "10")
          XCTAssertEqual(calculatorView.calculatorPresenter.status, .result)
     
    }
    
    func makeSUT() -> CalculatorView {
        let calculatorView = CalculatorView()
        trackForMemoryLeaks(calculatorView)
        trackForMemoryLeaks(calculatorView.calculatorPresenter)
        return calculatorView
    }
}

class CalculatorView {
    var displayContent: String = ""
    var calculatorPresenter: CalculatorPresenter = CalculatorPresenter()
    
    init() {
        self.calculatorPresenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
