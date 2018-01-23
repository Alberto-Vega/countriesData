//
//  SearchResultsViewController.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/23/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var countries = [Country]()
    var countriesTableView: UITableView = UITableView()
    var filteredCountries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupTableView()
        self.clearUserSelectedCell()
    }
    
    //MARK: - Helper Functions.
    
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
        return self.filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryNameCell", for: indexPath)
        let name: String
        name = self.filteredCountries[indexPath.row].name
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry: Country
        selectedCountry = self.filteredCountries[indexPath.row]
        
        let detailViewController = CountryDetailViewController()
        detailViewController.country = selectedCountry
        self.parent?.presentingViewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension SearchResultsViewController: UISearchResultsUpdating {
    
    // MARK: - UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        if let inputText = searchController.searchBar.text {
            self.filterContentForSearchText(inputText)
        }
    }
    
    fileprivate func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCountries = countries.filter({( country : Country) -> Bool in
            return country.name.lowercased().contains(searchText.lowercased())
        })
        self.countriesTableView.reloadData()
    }
}
