//
//  BrowseCountriesTests.swift
//  BrowseCountriesTests
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import XCTest
@testable import BrowseCountries

class MockURLSession: URLSessionProtocol {
    private (set) var urlCalled: URL?
    
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        urlCalled = url.url
        return URLSessionDataTask()
    }
    
    func resume() {
        
    }
}

class MockURLSessionDataTask {
    func resume() {
        
    }
}

class HTTPClientTests: XCTestCase {
    
    var httpClient: HTTPClient!
    var session: MockURLSession!

    override func setUp() {
        super.setUp()
        session = MockURLSession()
         httpClient = HTTPClient(session)
    }
    
    override func tearDown() {
        httpClient = nil
        super.tearDown()
    }
    
    func testIntialization() {
        XCTAssertNotNil(httpClient)
    }
    
    func testSessionGetsSetupAfterInitialization() {
        XCTAssertNotNil(httpClient.session)
    }
}
