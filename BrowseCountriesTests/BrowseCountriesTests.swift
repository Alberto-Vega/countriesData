//
//  BrowseCountriesTests.swift
//  BrowseCountriesTests
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import XCTest
@testable import BrowseCountries

class MockURLSession {
    
}

class BrowseCountriesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIntialization() {
        let sharedSession = URLSession.shared
        let httpClient = HTTPClient(sharedSession)
        
        XCTAssertNotNil(httpClient)
    }
    
    func testSessionGetsSeetupAfterInitialization() {
        let sharedSession = URLSession.shared
        let httpClient = HTTPClient(sharedSession)
        
        XCTAssertNotNil(httpClient.session)
    }
}
