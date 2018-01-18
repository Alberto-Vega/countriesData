//
//  CountryTests.swift
//  BrowseCountriesTests
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import XCTest
@testable import BrowseCountries

class CountryTests: XCTestCase {
    
    let afghanistanDictionary: [String: Any] = [
        "name": "Afghanistan",
        "topLevelDomain": [
            ".af"
        ],
        "alpha2Code": "AF",
        "alpha3Code": "AFG",
        "callingCodes": [
            "93"
        ],
        "capital": "Kabul",
        "altSpellings": [
            "AF",
            "Afġānistān"
        ],
        "region": "Asia",
        "subregion": "Southern Asia",
        "population": 26023100,
        "latlng": [
            33,
            65
        ],
        "demonym": "Afghan",
        "area": 652230,
        "gini": 27.8,
        "timezones": [
            "UTC+04:30"
        ],
        "borders": [
            "IRN",
            "PAK",
            "TKM",
            "UZB",
            "TJK",
            "CHN"
        ],
        "nativeName": "افغانستان",
        "numericCode": "004",
        "currencies": [
            "AFN"
        ],
        "languages": [
            "ps",
            "uz",
            "tk"
        ],
        "translations": [
            "de": "Afghanistan",
            "es": "Afganistán",
            "fr": "Afghanistan",
            "ja": "アフガニスタン",
            "it": "Afghanistan"
        ],
        "relevance": "0"
    ]
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCountryNameInitialization() {
        let country = try! Country(json: afghanistanDictionary)
        XCTAssert(country.name == "Afghanistan")
    }
    
    func testCountryCapitalInitialization() {
        let country = try! Country(json: afghanistanDictionary)
        XCTAssertEqual(country.capital, "Kabul")
        XCTAssertEqual(country.region, "Asia")
        XCTAssertEqual(country.subRegion, "Southern Asia")
        XCTAssertEqual(country.population, "26023100")
        XCTAssertEqual(country.latitude, 33)


    }
    
    func testMissingNameInitializationThrowsError() {
        let country = try! Country(json: afghanistanDictionary)
        XCTAssertThrowsError(try Country(json: ["Test": "Test"]))
        XCTAssertThrowsError(try Country(json: ["Test": "Test"]), "There was no name key in this dictionary") { (error) in
            XCTAssertEqual(error as! SerializationError, SerializationError.missing("name"))
        }
    }
    
    func testThrowError() {
        XCTAssertNoThrow(try Country(json: afghanistanDictionary))
    }
    
    func testInitializingCoordinatesWithIntegersSucceeds() {
        let country = try! Country(json: afghanistanDictionary)
        XCTAssert(country.latitude == 33 && country.longitude == 65)
    }
    
    func testInitializingCoordinatesWithDoublesSucceeds() {
        var countryWithCoordinatesAsDouble =  afghanistanDictionary
        countryWithCoordinatesAsDouble["latlng"] = [18.25,-63.16666666] as [Any]
        let country = try! Country(json: countryWithCoordinatesAsDouble)
        
        XCTAssert(country.latitude == 18.25 && country.longitude == -63.16666666)
    }
    
    
    
}
