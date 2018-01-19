//
//  HTTPClient.swift
//  Countries
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

typealias completion = ( _ data: Data?, _ error: Error?)->Void

enum HTTPClientError : Error {
    case UnableToCreateURL(String)
}

extension URLSession: URLSessionProtocol { }


class HTTPClient {
    
    let session: URLSessionProtocol
    
    init(_ session: URLSessionProtocol) {
        self.session = session
    }
    
    func getRequest(stringURL: String, completion: @escaping completion) {
        guard let url = URL(string: stringURL) else {
            print("Log Error: Unable to create URL from string")
            completion(nil, HTTPClientError.UnableToCreateURL("Unable to create URL object from string \(stringURL)"))
            return
        }
        
        let urlRequest = setupURLRequest(url)

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            completion(data, error)
        }
        task.resume()
    }
    
    fileprivate func setupURLRequest(_ url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("1IosQYQKu0mshuIZjcqiIXbiLGJSp1dBB9Yjsnfd2aISWLA7Yk", forHTTPHeaderField: "X-Mashape-Key")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
}
