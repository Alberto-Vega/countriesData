//
//  CountryNamesTableViewHelper.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/23/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import UIKit

class CountryNamesTableViewHelper: NSObject, UITableViewDataSource, UITableViewDelegate {
    let restCountriesClient = RestCountriesClient()
    var sections: [String :[Country]] = [:]
    var sectionTitles:[String] = []
    var countries = [Country]() {
        didSet {
            for country in countries {
                let initialLetter = String(country.name.prefix(1))
                if sections[initialLetter] != nil {
                    sections[initialLetter]?.append(country)
                } else {
                    sections[initialLetter] = [country]
                }
            }
            sectionTitles = Array(sections.keys)
            sectionTitles.sort()
        }
    }
    
    weak var viewController: CountryNamesTableViewController?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getData()  {
        self.restCountriesClient.getCountryData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.populateCountriesArray(_:)), name: didGetCountryData, object: nil)
    }
 
    @objc fileprivate func populateCountriesArray(_ notification: Notification) {
        self.countries = restCountriesClient.countries
        if let searchResultsController = self.viewController?.searchController.searchResultsController as? SearchResultsViewController {
            searchResultsController.countries = self.countries
        }
        
        DispatchQueue.main.async {
            self.viewController?.countriesTableView.reloadData()
        }
    }
    
    //MARK: - Table View Data Source and Delegate Methods.
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keyForSection = sectionTitles[section]
        return sections[keyForSection]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryNameCell", for: indexPath)
        let keyForCountrySection = sectionTitles[indexPath.section]
        if let countryValues = sections[keyForCountrySection] {
            let country = countryValues[indexPath.row]
            cell.textLabel?.text = country.name
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry: Country
        
        let keyForSection = sectionTitles[indexPath.section]
        if let countries = sections[keyForSection] {
            selectedCountry = countries[indexPath.row]
            let detailViewController = CountryDetailViewController()
            detailViewController.country = selectedCountry
            self.viewController?.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
