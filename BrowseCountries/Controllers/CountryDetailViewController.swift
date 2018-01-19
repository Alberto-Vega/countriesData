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
    var window: UIWindow?
    var mapView = MKMapView()
    var detailsContainer: CountryDetailContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        MAP HARDCODED Values
        if let country = self.country, let latitude = country.latitude, let longitude = country.longitude {
            let initialLocation = CLLocation(latitude: latitude , longitude: longitude)
            let area = country.area ?? Double(3000000000000000.00)
            let regionRadius: CLLocationDistance = area
            self.centerMapOnLocation(location: initialLocation, regionRadius: regionRadius)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        let margins = view.layoutMarginsGuide
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.50).isActive = true
        
        detailsContainer = CountryDetailContainer(parentView: self.view)
        detailsContainer?.mainView.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        detailsContainer?.mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailsContainer?.mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        detailsContainer?.setupConstraints()
        
        if let country = self.country {
            detailsContainer?.populateUIFor(country:country)

            //alpha2code
            let urlString = "http://www.geonames.org/flags/l/af.gif"
//            detailsContainer?.countryFlagImageView.downloadedFrom(link: urlString, contentMode: UIViewContentMode.scaleAspectFit)
        }
    }

    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func centerMapOnRect(location:CLLocation, regionRect: MKMapRect) {
        mapView.setVisibleMapRect(regionRect, animated: true)
    }
}
