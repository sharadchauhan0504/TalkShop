//
//  HomeFeedResponse.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 17/02/24.
//

import Foundation

// MARK: - HomeFeedResponse
struct HomeFeedResponse: Codable {
    let status: String
    let data: [HomeFeed]
}

// MARK: - Datum
struct HomeFeed: Codable {
    let postId: String
    let videoUrl: String
    let thumbnailURL: String
    let username: String
    var likes: Int
    let profilePictureUrl: String

    enum CodingKeys: String, CodingKey {
        case thumbnailURL = "thumbnail_url"
        case username, likes, profilePictureUrl, postId, videoUrl
    }
}
