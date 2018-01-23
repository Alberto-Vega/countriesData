//
//  ViewController.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import UIKit

class CountryNamesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var countries = [Country]()
    var countriesTableView: UITableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
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
    
    @objc fileprivate func populateCountriesArray(_ notification: Notification) {
        self.countries = restCountriesClient.countries
        DispatchQueue.main.async {
            self.countriesTableView.reloadData()
        }
    }
    fileprivate func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return self.filteredCountries.count
        }
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryNameCell", for: indexPath)
        let name: String
        if isFiltering() {
            name = self.filteredCountries[indexPath.row].name
        } else {
            name = self.countries[indexPath.row].name
        }
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry: Country
        if isFiltering() {
            selectedCountry = self.filteredCountries[indexPath.row]
        } else {
            selectedCountry = self.countries[indexPath.row]
        }
        let detailViewController = CountryDetailViewController()
        detailViewController.country = selectedCountry
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func isFiltering() -> Bool {
        return self.searchController.isActive && !searchBarIsEmpty()
    }
    
    fileprivate func searchBarIsEmpty() -> Bool {
        return self.searchController.searchBar.text?.isEmpty ?? true
    }
}

extension CountryNamesTableViewController: UISearchResultsUpdating {
    
    // MARK: - UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContentForSearchText(searchController.searchBar.text!)
    }
    
    fileprivate func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCountries = countries.filter({( country : Country) -> Bool in
            return country.name.lowercased().contains(searchText.lowercased())
        })
        self.countriesTableView.reloadData()
    }
}

