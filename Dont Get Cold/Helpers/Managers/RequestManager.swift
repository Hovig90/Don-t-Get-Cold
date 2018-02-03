//
//  RequestManager.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/23/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

class RequestManager {
    
    //MARK: Members
    static let session = URLSession(configuration: .default)
    static var dataTask: URLSessionDataTask?
    
    static func request(withURL url: String, parameters: String, compeletion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: url) {
            urlComponents.query = parameters
            guard let url = urlComponents.url else { return }
            
            dataTask = session.dataTask(with: url, completionHandler: { (data, responce, error) in
                compeletion(data, responce, error)
            })
        }
        dataTask?.resume()
    }
}
