//
//  GenericAPIErrors.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 15/02/24.
//

import Foundation

//MARK:- Generic errors in App
enum GenericAPIErrors: Error {
    
    case invalidAPIResponse
    case decodingError
    
    var message: String {
        switch self {
        case .invalidAPIResponse: return "The page you’re requesting appears to be stuck in traffic. Refresh to retrieve!"
        case .decodingError: return "Our servers started speaking a language we are yet to learn. Bear with us."
        }
    }
    
}
