//
//  ViewController.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCountryData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func getCountryData() {
        let stringURL = "https://restcountries-v1.p.mashape.com/all"
        let HTTPClientInstance = HTTPClient(URLSession.shared)
        HTTPClientInstance.getRequest(stringURL: stringURL) { (data, error) in
            if let data = data {
                do {
                     let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let array = json as? [Any] {
                    for object in array {
                        print(object as? [String : Any] ?? "Failed")
                        // access all objects in array
                    }
                    }
                } catch let error {
                    print("Log: \(error.localizedDescription)")
                }
            } else {
                print("Log Error: No data was returned from request to: \(stringURL) \(String(describing: error?.localizedDescription))")
            }
        }
    }


}

