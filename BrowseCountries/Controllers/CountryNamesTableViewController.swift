//
//  ViewController.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import UIKit

class CountryNamesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var countries : [Country?]?
    var countriesTableView: UITableView  =   UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCountryData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Country List"
        self.setupTableView()
    }
    
    fileprivate func getCountryData() {
        let stringURL = "https://restcountries-v1.p.mashape.com/all"
        let HTTPClientInstance = HTTPClient(URLSession.shared)
        HTTPClientInstance.getRequest(stringURL: stringURL) { (data, error) in
            guard let data = data else {
                print("Log Error: No data was returned from request to: \(stringURL) \(String(describing: error?.localizedDescription))")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let arrayFromJSON = json as? [Any] else {
                    print("Log Error: unable to cast JSON to array of type Any")
                    return
                }
                self.countries = Array(repeatElement(nil, count: arrayFromJSON.count))
                
                for (index, object) in arrayFromJSON.enumerated() {
                    guard let contryJSON = object as? [String : Any] else {
                        print("Log Error: unable to cast serialized country object from Any to dictionary, failed with object at index: \(index) ")
                        continue
                    }
                    self.buildContryInstances(contryJSON, index)
                }
                DispatchQueue.main.async {
                    self.countriesTableView.reloadData()
                }
            } catch let error {
                print("Log: \(error.localizedDescription)")
            }
        }
    }
    
    fileprivate func buildContryInstances(_ contryJSON: [String : Any], _ index: Int) {
        do{
            let currentCountry = try Country(json: contryJSON)
            self.countries?[index] = currentCountry
        } catch let error {
            print("Log Error: \(error.localizedDescription)")
        }
    }
    
    fileprivate func setupTableView() {
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
        countriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "countryNameCell")
        self.view.addSubview(countriesTableView)
        
        countriesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countriesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            countriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    //: MARK - Table View Data Source and Delegate Methods.
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries?.count ?? 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryNameCell", for: indexPath)
        cell.textLabel?.text = self.countries?[indexPath.row]?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCountry = self.countries?[indexPath.row] else {
            print("Log: failed to get optional country selected by cell tapped")
            return
        }
        let detailViewController = CountryDetailViewController()
        detailViewController.country = selectedCountry
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

}

