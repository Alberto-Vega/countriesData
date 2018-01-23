//
//  CountryDetailViewController.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/18/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import UIKit
import MapKit

class CountryDetailViewController: UIViewController {
    
    var country: Country?
    var mapView = MKMapView()
    var detailsContainer: CountryDetailContainer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupMapView()
        self.setupDetailsContainerView()
        self.displaySelectedCountryOnMapView()
    }
    
    //MARK: - Helper Functions.
    
    fileprivate func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        let margins = view.layoutMarginsGuide
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.50).isActive = true
    }
    
    fileprivate func setupDetailsContainerView() {
        detailsContainer = CountryDetailContainer(parentView: self.view)
        detailsContainer?.mainView.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        detailsContainer?.mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailsContainer?.mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        detailsContainer?.setupConstraints()
        if let country = self.country {
            detailsContainer?.populateUIFor(country:country)
        }
    }
    
    fileprivate func displaySelectedCountryOnMapView() {
        if let country = self.country,
            let latitude = country.latitude,
            let longitude = country.longitude,
            let area = country.area
        {
            let initialLocation = CLLocation(latitude: latitude , longitude: longitude)
            let area = self.calculateAreaDiameterInMeters(area)
            let regionRadius: CLLocationDistance = area
            self.centerMapOnLocation(location: initialLocation, regionDiameter: regionRadius)
        } else {
            print("Log Error: unable to display country \(self.country?.name ?? "") coordinates are nil")
            self.alertUserOfMissingCoordinates()
        }
    }
    
    fileprivate func calculateAreaDiameterInMeters(_ area: Double) -> Double {
        return area < 400 ? area * 1000 : area.squareRoot() * 1000
    }
    
    fileprivate func alertUserOfMissingCoordinates() {
        let alertController = UIAlertController(title: "Sorry!", message: "Coordinate data unavailable.", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func centerMapOnLocation(location: CLLocation, regionDiameter: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionDiameter, regionDiameter)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.regionThatFits(coordinateRegion)
    }

    fileprivate func centerMapOnRect(location:CLLocation, regionRect: MKMapRect) {
        mapView.setVisibleMapRect(regionRect, animated: true)
    }
}
