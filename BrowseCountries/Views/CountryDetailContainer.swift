//
//  CountryDetailContainerView.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/18/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import UIKit

class CountryDetailContainer {
    //first container view.
    let mainView: UIView
    let countryFlagImageView: UIImageView
    private let detailsHeaderView: UIView
    private let countryNameLabel: UILabel
    private let detailsBodyView: UIView

    private let capitalNameLabel:UILabel
    private let regionLabel: UILabel
    private let subRegionLabel: UILabel
    private let populationLabel: UILabel
    
    init(parentView: UIView) {
        self.mainView = UIView()
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(mainView)
        let margins = parentView.layoutMarginsGuide
        mainView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.50).isActive = true
        
        //Header and subviews.
        detailsHeaderView = UIView()
        mainView.addSubview(detailsHeaderView)
        
        countryFlagImageView = UIImageView()
        detailsHeaderView.addSubview(countryFlagImageView)
        
        countryNameLabel = UILabel()
        detailsHeaderView.addSubview(countryNameLabel)
        
        //Body and  subviews
        detailsBodyView = UIView()
        mainView.addSubview(detailsBodyView)

        capitalNameLabel = UILabel()
        mainView.addSubview(capitalNameLabel)
        
        regionLabel = UILabel()
        mainView.addSubview(regionLabel)
        
        subRegionLabel = UILabel()
        mainView.addSubview(subRegionLabel)
        
        populationLabel = UILabel()
        mainView.addSubview(populationLabel)
    }
    
    func setupConstraints() {
        countryFlagImageView.translatesAutoresizingMaskIntoConstraints = false
        countryFlagImageView.leadingAnchor.constraint(equalTo: detailsHeaderView.leadingAnchor, constant: 10.0).isActive = true
        countryFlagImageView.topAnchor.constraint(equalTo: detailsHeaderView.topAnchor, constant: 10.0).isActive = true
        countryFlagImageView.bottomAnchor.constraint(equalTo: detailsHeaderView.bottomAnchor, constant: -10.0).isActive = true
        countryFlagImageView.widthAnchor.constraint(equalTo: detailsHeaderView.widthAnchor, multiplier: 0.30).isActive = true
        
        detailsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        detailsHeaderView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        detailsHeaderView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        detailsHeaderView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        detailsHeaderView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.30).isActive = true
        
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryNameLabel.leadingAnchor.constraint(equalTo: countryFlagImageView.trailingAnchor, constant: 10.0).isActive = true
        countryNameLabel.trailingAnchor.constraint(equalTo: detailsHeaderView.trailingAnchor, constant: 10.0).isActive = true
        countryNameLabel.centerYAnchor.constraint(equalTo: countryFlagImageView.centerYAnchor, constant: 0.0).isActive = true

        detailsBodyView.translatesAutoresizingMaskIntoConstraints = false
        detailsBodyView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10.0).isActive = true
        detailsBodyView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        detailsBodyView.topAnchor.constraint(equalTo: detailsHeaderView.bottomAnchor).isActive = true
        detailsBodyView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.70).isActive = true
        
        setupConstraintsFor(label: capitalNameLabel, below: detailsHeaderView, constant: 10.0)
        setupConstraintsFor(label: regionLabel, below: capitalNameLabel, constant: 0.0)
        setupConstraintsFor(label: subRegionLabel, below: regionLabel, constant: 0)
        setupConstraintsFor(label: populationLabel, below: subRegionLabel, constant: 0)

    }
    
    fileprivate func setupConstraintsFor(label: UILabel, below topView: UIView, constant: CGFloat) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: constant).isActive = true
        label.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: constant).isActive = true
        label.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: constant).isActive = true
    }
    
    func populateUIFor(country: Country) {
        countryNameLabel.text = country.name
        capitalNameLabel.text = "Capital: \(country.capital)"
        regionLabel.text = "Region: \(country.region)"
        subRegionLabel.text = "SubRegion: \(country.subRegion)"
        populationLabel.text = "Population: \(country.population)"
        let urlString = "http://www.geonames.org/flags/l/\(country.alpha2Code).gif"
        countryFlagImageView.downloadedFrom(link: urlString, contentMode: UIViewContentMode.scaleAspectFit)

    }
}
