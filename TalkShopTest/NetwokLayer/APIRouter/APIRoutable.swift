//
//  HomeScreenController.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 15/02/24.
//

import Foundation

//MARK:- Protocol
protocol APIRoutable {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var endPoint: String { get }
    var body: Data? { get }
    var request: URLRequest { get }
}

extension APIRoutable {
    
    var request: URLRequest {
        var request                 = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpBody            = body
        request.httpMethod          = method.rawValue
        request.cachePolicy         = .reloadRevalidatingCacheData
        return request
    }
    
}
