//
//  ArithmeticOperationsTests.swift
//  calculatorTests
//
//  Created by Iram Martinez on 17/08/22.
//

import XCTest
@testable import calculator

class ArithmeticOperationsTests: XCTestCase {
    let arithmeticOperations = ArithmeticOperations()
    
    func test_additionOfTwoIntegers() throws {
        let addition = arithmeticOperations.addition(firstNumber: 1, secondNumber: 6)
        XCTAssertEqual(addition, 7)
    }
    
    func test_additionOfTwoFloatNumbers() throws {
        let addition = arithmeticOperations.addition(firstNumber: 5.0, secondNumber: 4.0)
        XCTAssertEqual(addition, 9.0)
    }
    
    func test_substractionOfTwoIntegers() throws {
        let substraction = arithmeticOperations.substraction(firstNumber: 1, secondNumber: 6)
        XCTAssertEqual(substraction, -5)
    }
    
    func test_substractionOfTwoFloatNumbers() throws {
        let substraction = arithmeticOperations.substraction(firstNumber: 5.0, secondNumber: 4.0)
        XCTAssertEqual(substraction, 1.0)
    }
    
    func test_divisionOfTwoIntegers() throws {
        let division = arithmeticOperations.division(firstNumber: 6, secondNumber: 2)
        XCTAssertEqual(division, 3.0)
    }
    
    func test_divisionOfTwoFloatNumbers() throws {
        let division = arithmeticOperations.division(firstNumber: 5.5, secondNumber: 1.0)
        XCTAssertEqual(division, 5.5)
    }
    
    func test_divisionOfTwoFloatNumbers_shouldFail() throws {
        let division = arithmeticOperations.division(firstNumber: 20.0, secondNumber: 0.0)
        XCTAssertEqual(division.decimalValue, Decimal.nan)
    }
    
    func test_notANumberDivisionNumbers() {
        let division = arithmeticOperations.division(firstNumber: Decimal.nan, secondNumber: Decimal.nan)
        XCTAssertEqual(division.decimalValue, Decimal.nan)
    }
    
    func test_multiplicationOfTwoIntegers() throws {
        let multiplication = arithmeticOperations.multiplication(firstNumber: 20, secondNumber: 2)
        XCTAssertEqual(multiplication, 40)
    }
    
    func test_multiplicationOfTwoFloats() throws {
        let multiplication = arithmeticOperations.multiplication(firstNumber: 20.0, secondNumber: 1.0)
        XCTAssertEqual(multiplication, 20.0)
    }

}
