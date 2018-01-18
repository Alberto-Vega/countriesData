//
//  HTTPClient.swift
//  Countries
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    <#requirements#>
}
class HTTPClient {
    let session: URLSession
    
    init(_ session: URLSession) {
        self.session = session
    }
    
    func getRequest(<#parameters#>) -> <#return type#> {
        <#function body#>
    }
}
