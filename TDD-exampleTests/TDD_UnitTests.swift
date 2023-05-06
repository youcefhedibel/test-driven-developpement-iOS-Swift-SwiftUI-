//
//  TDD_exampleTests.swift
//  TDD-exampleTests
//
//  Created by mac on 9/3/2023.
//

import XCTest

class whenCalculatingTipBasedOnTotalAmount: XCTestCase {

    func testShouldCalculateTipSuccessfully() {
        
        let tipCalculator = TipCalculator()
        let tip = try! tipCalculator.calculate(total: 200, tipPercentage: 0.1)
        XCTAssertEqual(20, tip)
        
    }
}

class whenCalculatingTipBasedOnNegativeTotalAmount: XCTestCase {
    
    func testShouldThrowInvalidInputException() {
        
        let tipCalculator = TipCalculator()
        
        XCTAssertThrowsError(try tipCalculator.calculate(total: -100, tipPercentage: 0.1), "") { error in
            XCTAssertEqual(error as! TipCalculatorError, TipCalculatorError.invalidInput)
        }
        
    }
    
}
