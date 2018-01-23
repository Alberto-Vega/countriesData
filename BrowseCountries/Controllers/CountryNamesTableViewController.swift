//
//  ViewController.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import UIKit

class Adapter: NSObject {
    let val: Country
    
    init(val: Country) {
        self.val = val
    }
    
    @objc var name: String {
        return val.name
    }
}

class CountryNamesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    let collation = UILocalizedIndexedCollation.current()
    var sections: [[Any]] = []
    var countries = [Country]()
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
    
    // MARK: UITableViewDelegate

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return collation.sectionTitles[section]
//    }
//
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return collation.sectionIndexTitles
//    }
//
//    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        if index == 0 {
//            tableView.scrollRectToVisible((tableView.tableHeaderView?.frame)!, animated: true)
//            return index-1
//        }
//        return collation.section(forSectionIndexTitle: index)
//    }
    
    //MARK: - Table View Data Source and Delegate Methods.

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryNameCell", for: indexPath)
        let name: String
            name = self.countries[indexPath.row].name
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry: Country
            selectedCountry = self.countries[indexPath.row]
        let detailViewController = CountryDetailViewController()
        detailViewController.country = selectedCountry
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

