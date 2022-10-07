//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAddition() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Given
        let countModel = CountModel()
        
        let left: Double = 1
        let right: Double = 2
        // when
        
        let countResutlt = countModel.addition(a: left, b: right)
        // Then
        XCTAssertEqual( countResutlt, left + right)
    }
    
    func testMultiply() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Given
        let countModel = CountModel()
        
        let left: Double = 1
        let right: Double = 2
        // when
        
        let countResutlt = countModel.multiply(a: left, b: right)
        // Then
        XCTAssertEqual( countResutlt, left * right)
    }
    
    func testDivide() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Given
        let countModel = CountModel()
        
        let left: Double = 4.0
        let right: Double = 2.0
        // when
        
        let countResutlt = countModel.divide(a: left, b: right)
        // Then
        XCTAssertEqual( countResutlt, left/right)
    }
    
    func testDivideZero() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Given
        let countModel = CountModel()
        
        let left: Double = 1.0
        let right: Double = 0
        // when
        
        let countResutlt = countModel.divide(a: left, b: right)
        // Then
        XCTAssertEqual( countResutlt, .infinity)
    }
    
    func testSoustraction() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Given
        let countModel = CountModel()
        
        let left: Double = 3
        let right: Double = 2
        // when
        
        let countResutlt = countModel.substraction(a: left, b: right)
        // Then
        XCTAssertEqual( countResutlt, left - right)
    }
    
    func testOperation() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Given
        let stringMock = "2 + 4 / 6 x 12 - 3"
        let countModel = CountModel()
        
        // when
        let countResutlt = countModel.operation(operation: stringMock)
        // Then
        XCTAssertEqual( countResutlt, 7)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
