//
//  RestCountiesClient.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/22/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import Foundation

let didGetCountryData = Notification.Name("restCountriesClientDidGetCountryDataNotification")

class RestCountriesClient {
    
    public private (set) var countries = [Country]()
    
    func getCountryData () {
        self.getCountryData { (data, error) in
            guard let data = data else {
                print("Log Error: No data was returned from RestCountiesClient request \(String(describing: error?.localizedDescription))")
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let arrayFromJSON = json as? [Any] else {
                    print("Log Error: unable to cast JSON to array of type Any")
                    return
                }
                
                self.countries = arrayFromJSON.flatMap({ self.buildContryInstances($0 as! [String : Any]) })
                NotificationCenter.default.post(name: didGetCountryData, object: self, userInfo: nil)

            } catch let error {
                print("Log: \(error.localizedDescription)")
            }
        }
    }
    
    fileprivate func getCountryData(completion: @escaping completion) {
        let stringURL = "https://restcountries-v1.p.mashape.com/all"
        let HTTPClientInstance = HTTPClient(URLSession.shared)
        HTTPClientInstance.getRequest(stringURL: stringURL) { (data, error) in
            completion(data, error)
        }
    }
    
    fileprivate func buildContryInstances(_ contryJSON: [String : Any]) -> Country? {
        do{
            let currentCountry = try Country(json: contryJSON)
            return currentCountry
        } catch SerializationError.missing(let message) {
            print("Log Error: \(message)")
        } catch SerializationError.invalid(let message) {
            print("Log Error: \(message)")
        } catch let error {
            print("Log Error: \(error.localizedDescription)")
        }
        return nil
    }
}
