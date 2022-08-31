//
//  calculatorUITests.swift
//  calculatorUITests
//
//  Created by Iram Martinez on 17/08/22.
//

import XCTest

class calculatorUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func test_sum() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        let displayLabel = app.staticTexts["displayLabel"]
        XCTAssertEqual(displayLabel.label, "1")
        app.buttons["+"].tap()
        XCTAssertEqual(displayLabel.label, "+")
        app.buttons["3"].tap()
        XCTAssertEqual(displayLabel.label, "3")
        app.buttons["="].tap()
        XCTAssertEqual(displayLabel.label, "4.0")
    }
    
    func test_delete_all() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["5"].tap()
        let displayLabel = app.staticTexts["displayLabel"]
        app.buttons["5"].tap()
        app.buttons["1"].tap()
        XCTAssertEqual(displayLabel.label, "551")
        app.buttons["AC"].tap()
        app.buttons["4"].tap()
        
        XCTAssertEqual(displayLabel.label, "4")
    }
    
    func test_numbers_with_dot_sum() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["7"].tap()
        app.buttons["."].tap()
        app.buttons["3"].tap()
        let displayLabel = app.staticTexts["displayLabel"]
        XCTAssertEqual(displayLabel.label, "7.3")
        app.buttons["+"].tap()
        XCTAssertEqual(displayLabel.label, "+")
        app.buttons["3"].tap()
        app.buttons["."].tap()
        app.buttons["4"].tap()
        XCTAssertEqual(displayLabel.label, "3.4")
        app.buttons["="].tap()
        XCTAssertEqual(displayLabel.label, "10.7")
    }
    
    
    
    func test_division_of_any_number_and_zero() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["4"].tap()
        let displayLabel = app.staticTexts["displayLabel"]
        XCTAssertEqual(displayLabel.label, "4")
        app.buttons["/"].tap()
        XCTAssertEqual(displayLabel.label, "/")
        app.buttons["0"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(displayLabel.label, "No puedes dividir entre 0")
    }
}
