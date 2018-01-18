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
    let nameContainerView = UIView()
    
//    init(country: Country) {
//        self.country = country
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsCompass = true
        mapView.showsScale = true 
        view.addSubview(mapView)
        let margins = view.layoutMarginsGuide
//        mapView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true

//        mapView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
                mapView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true

        mapView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.50).isActive = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
