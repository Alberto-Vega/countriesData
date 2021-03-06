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
        self.mainView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.50).isActive = true
        
        //Header and subviews.
        self.detailsHeaderView = UIView()
        self.mainView.addSubview(detailsHeaderView)
        
        self.countryFlagImageView = UIImageView()
        self.detailsHeaderView.addSubview(countryFlagImageView)
        
        self.countryNameLabel = UILabel()
        self.countryNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping;
        self.countryNameLabel.numberOfLines = 2;
        self.detailsHeaderView.addSubview(countryNameLabel)
        
        //Body and  subviews
        self.detailsBodyView = UIView()
        self.mainView.addSubview(detailsBodyView)

        self.capitalNameLabel = UILabel()
        self.mainView.addSubview(capitalNameLabel)
        
        self.regionLabel = UILabel()
        self.mainView.addSubview(regionLabel)
        
        self.subRegionLabel = UILabel()
        self.mainView.addSubview(subRegionLabel)
        
        self.populationLabel = UILabel()
        self.mainView.addSubview(populationLabel)
    }
    
    func setupInternalViewsConstraints() {
        self.countryFlagImageView.translatesAutoresizingMaskIntoConstraints = false
        self.countryFlagImageView.leadingAnchor.constraint(equalTo: detailsHeaderView.leadingAnchor, constant: 10.0).isActive = true
        self.countryFlagImageView.topAnchor.constraint(equalTo: detailsHeaderView.topAnchor, constant: 10.0).isActive = true
        self.countryFlagImageView.bottomAnchor.constraint(equalTo: detailsHeaderView.bottomAnchor, constant: -10.0).isActive = true
        self.countryFlagImageView.widthAnchor.constraint(equalTo: detailsHeaderView.widthAnchor, multiplier: 0.30).isActive = true
        
        self.detailsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.detailsHeaderView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        self.detailsHeaderView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        self.detailsHeaderView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        self.detailsHeaderView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.30).isActive = true
        
        self.countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.countryNameLabel.leadingAnchor.constraint(equalTo: countryFlagImageView.trailingAnchor, constant: 10.0).isActive = true
        self.countryNameLabel.trailingAnchor.constraint(equalTo: detailsHeaderView.trailingAnchor, constant: -10.0).isActive = true
        self.countryNameLabel.centerYAnchor.constraint(equalTo: countryFlagImageView.centerYAnchor, constant: 0.0).isActive = true

        self.detailsBodyView.translatesAutoresizingMaskIntoConstraints = false
        self.detailsBodyView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10.0).isActive = true
        self.detailsBodyView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        self.detailsBodyView.topAnchor.constraint(equalTo: detailsHeaderView.bottomAnchor).isActive = true
        self.detailsBodyView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.70).isActive = true
        
        self.setupConstraintsFor(label: capitalNameLabel, below: detailsHeaderView, constant: 10.0)
        self.setupConstraintsFor(label: regionLabel, below: capitalNameLabel, constant: 0.0)
        self.setupConstraintsFor(label: subRegionLabel, below: regionLabel, constant: 0)
        self.setupConstraintsFor(label: populationLabel, below: subRegionLabel, constant: 0)
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
        countryFlagImageView.downloadedFrom(link: country.flagImageURLString, contentMode: UIViewContentMode.scaleAspectFit)
    }
}
