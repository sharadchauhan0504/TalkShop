//
//  UserDataAPIServices.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 18/02/24.
//

import Foundation

enum UserDataAPIServices: APIRoutable {
    
    case profileDetails(_ username: String)
    
    var url: URL {
        return URL(string: APIClient.baseUrl + endPoint)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .profileDetails: return .GET
        }
    }
    
    var endPoint: String {
        switch self {
        case .profileDetails(let username): return "/profile/\(username)"
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .profileDetails: return [
            "Content-Type": "application/json"
        ]
        }
    }
    
    var body: Data? {
        switch self {
        case .profileDetails: nil
        }
    }

}
