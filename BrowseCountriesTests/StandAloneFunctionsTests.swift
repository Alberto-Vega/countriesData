//
//  StandAloneFunctionsTests.swift
//  BrowseCountriesTests
//
//  Created by Alberto Vega Gonzalez on 1/22/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import XCTest
@testable import BrowseCountries

class StandAloneFunctionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConvertIntToDouble() {
        let numberAny: Any = 1234
        let doubleNumber: Double = convertToDouble(numberAny)!
        let sameDoubleNumber: Double = 1234
        XCTAssert(doubleNumber == sameDoubleNumber)
    }
    
    func testConvertDoubleToDouble() {
        let numberAny: Any = 1234.0
        let doubleNumber: Double? = convertToDouble(numberAny)
        let sameDoubleNumber: Double = 1234
        XCTAssert(doubleNumber == sameDoubleNumber)
    }
}
