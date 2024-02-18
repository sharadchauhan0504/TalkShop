//
//  FeedDataAPIService.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 15/02/24.
//


import Foundation

enum FeedDataAPIService: APIRoutable {
    
    case feed
    case postDetails(_ id: String)
    
    var url: URL {
        return URL(string: APIClient.baseUrl + endPoint)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .feed, .postDetails: return .GET
        }
    }
    
    var endPoint: String {
        switch self {
        case .feed: return "/feed"
        case .postDetails(let id): return "/post/\(id)"
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .feed, .postDetails: return [
            "Content-Type": "application/json"
        ]
        }
    }
    
    var body: Data? {
        switch self {
        case .feed, .postDetails: nil
        }
    }

}
