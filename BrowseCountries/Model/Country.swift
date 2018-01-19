//
//  Country.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import Foundation

enum SerializationError: Error, Equatable {
    case missing(String)
    case invalid(String)

    static func ==(lhs: SerializationError, rhs: SerializationError) -> Bool {
        switch (lhs, rhs) {
        case (.missing(let leftMessage), .missing(let rightMessage)):
            return leftMessage == rightMessage
        case (.invalid(let lefttMessage), .invalid(let rightMessage)):
            return lefttMessage == rightMessage
        default:
            return false
        }
    }
}

struct Country {
    let name: String
    let capital: String
    let region: String
    let subRegion: String
    let population: String
    let latitude: Double?
    let longitude: Double?
    let area: Double?
    let alpha2Code: String
    
    init(json: [String: Any]) throws {
        guard let name = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        guard let capital = json["capital"] as? String else {
            throw SerializationError.missing("capital")
        }
        guard let region = json["region"] as? String else {
            throw SerializationError.missing("region")
        }
        guard let subRegion = json["subregion"] as? String else {
            throw SerializationError.missing("subregion")
        }
        guard let population = json["population"] as? NSNumber else {
            throw SerializationError.missing("population")
        }
        guard let latLong = json["latlng"] as? [Any] else {
            throw SerializationError.invalid("latlng")
        }
        guard latLong.count == 2 else {
            throw SerializationError.invalid("Invalid coordinates we got \(latLong.count) position points")
        }
        guard let alpha2Code = json["alpha2Code"] as? String else {
            throw SerializationError.missing("alpha2Code")
        }
                
        self.name = name
        self.capital = capital
        self.region = region
        self.subRegion = subRegion
        self.population = String(formatToReadable(number: population))
        self.latitude = convertToDouble(latLong[0])
        self.longitude = convertToDouble(latLong[1])
        self.area = json["area"] as? Double
        self.alpha2Code = alpha2Code.lowercased()
    }
}

// MARK: - Stand alone utility functions.

func formatToReadable(number: NSNumber) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.locale = Locale.current
    return formatter.string(from: number) ?? "unable to format the number"
}

func convertToDouble(_ number: Any) -> Double? {
    guard let double = number as? Double else {
        if let integer = number as? Int {
            return Double(integer)
        }
        return number as? Double
    }
    return double
}

