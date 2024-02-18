//
//  HomeScreenViewModel.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 16/02/24.
//

import Foundation

final class HomeScreenViewModel {
    
    //MARK: - Callbacks
    var errorCallback: ((String?) -> Void)?
    var feedDataCallback: (() -> Void)?
    var postDetailsCallback: ((HomeFeed?) -> Void)?
    
    //MARK: - Private variables
    private let session = MockURLSession()
    
    //MARK: - Public variables
    var feedData: [HomeFeed] = []
    
    
    //MARK: - Actions
    func callAsFunction(_ action: HomeScreenActions) {
        switch action {
        case .feedData: getFeedData()
        case .postDetails(let id): postDetails(id)
        }
    }
    
    //MARK: - Private methods
    private func getFeedData() {
        session.testDataJSONFile = "home_feed"
        let api                  = FeedDataAPIService.feed
        let router               = APIRouter<HomeFeedResponse>(session: session)
        router.requestData(api) { [weak self] (output, statusCode, error) in
            guard let self else {return}
            if let data = output?.data {
                self.feedData = data
                self.feedDataCallback?()
            } else {
                self.errorCallback?(error?.localizedDescription)
            }
        }
    }
    
    private func postDetails(_ id: String) {
        session.testDataJSONFile = "post_details"
        let api                  = FeedDataAPIService.feed
        let router               = APIRouter<PostDetailsResponse>(session: session)
        router.requestData(api) { [weak self] (output, statusCode, error) in
            guard let self else {return}
            if output?.data != nil {
                let postData = self.feedData.filter { $0.postId == id }.first
                self.postDetailsCallback?(postData)
            } else {
                self.errorCallback?(error?.localizedDescription)
            }
        }
    }
    
}
