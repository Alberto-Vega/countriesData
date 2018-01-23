//
//  ViewController.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import UIKit


class CountryNamesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
    var countriesTableView: UITableView = UITableView()
    var searchController:UISearchController!
    let restCountriesClient = RestCountriesClient()
    var filteredCountries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        restCountriesClient.getCountryData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.populateCountriesArray(_:)), name: didGetCountryData, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Country List"
        self.setupTableView()
        self.clearUserSelectedCell()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Helper Functions.
    
    fileprivate func setupSearchController() {
        let searchResultsViewController = SearchResultsViewController()
        searchResultsViewController.countries = self.countries
        self.searchController = UISearchController(searchResultsController: searchResultsViewController)
        self.searchController.searchResultsUpdater = searchResultsViewController
        self.searchController.obscuresBackgroundDuringPresentation = true
        self.searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.definesPresentationContext = true;
        
    }
    
    @objc fileprivate func populateCountriesArray(_ notification: Notification) {
        self.countries = restCountriesClient.countries
        if let searchResultsController = self.searchController.searchResultsController as? SearchResultsViewController {
            searchResultsController.countries = self.countries
        }
        
        DispatchQueue.main.async {
            self.countriesTableView.reloadData()
        }
    }
    
    fileprivate func setupTableView() {
        self.countriesTableView.dataSource = self
        self.countriesTableView.delegate = self
        self.countriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "countryNameCell")
        self.view.addSubview(countriesTableView)
        
        self.countriesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.countriesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            self.countriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.countriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.countriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    fileprivate func clearUserSelectedCell() {
        if let index = self.countriesTableView.indexPathForSelectedRow{
            self.countriesTableView.deselectRow(at: index, animated: true)
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
        if let countries = sections[keyForSection] {
            return countries.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryNameCell", for: indexPath)
        let keyForCountrySection = sectionTitles[indexPath.section]
        if let countryValues = sections[keyForCountrySection] {
            let name = countryValues[indexPath.row].name
            cell.textLabel?.text = name
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
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

