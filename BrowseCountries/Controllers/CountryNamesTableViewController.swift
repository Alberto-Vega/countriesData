//
//  ViewController.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import UIKit


class CountryNamesTableViewController: UIViewController {

    var countriesTableView: UITableView = UITableView()
    let countryNamesTableViewHelper = CountryNamesTableViewHelper()
    var searchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.setupNavigationBarAppearance()
        self.setupTableView()
        self.countryNamesTableViewHelper.viewController = self
        self.countryNamesTableViewHelper.getData()
        self.navigationController?.navigationBar.topItem?.title = "Country List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.clearUserSelectedCell()
    }
        
    //MARK: - Helper Functions.
    
    fileprivate func setupSearchController() {
        let searchResultsViewController = SearchResultsViewController()
        self.searchController = UISearchController(searchResultsController: searchResultsViewController)
        self.searchController.searchResultsUpdater = searchResultsViewController
        self.searchController.obscuresBackgroundDuringPresentation = true
        self.searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true;
    }
    
    fileprivate func setupNavigationBarAppearance() {
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    fileprivate func setupTableView() {
        self.countriesTableView.dataSource = self.countryNamesTableViewHelper
        self.countriesTableView.delegate = self.countryNamesTableViewHelper
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
    
}

