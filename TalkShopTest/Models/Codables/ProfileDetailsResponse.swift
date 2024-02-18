//
//  ProfileDetailsResponse.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 18/02/24.
//

import Foundation

// MARK: - ProfileDetailsResponse
struct ProfileDetailsResponse: Codable {
    let status: String
    let data: ProfileDetails
}

// MARK: - DataClass
struct ProfileDetails: Codable {
    let username: String
    let profilePictureUrl: String
    let posts: [HomeFeed]
}
