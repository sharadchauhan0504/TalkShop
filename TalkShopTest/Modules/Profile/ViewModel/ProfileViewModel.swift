//
//  ProfileViewModel.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 18/02/24.
//

import Foundation

final class ProfileViewModel {
    
    //MARK: - Callbacks
    var errorCallback: ((String?) -> Void)?
    var profileDataCallback: ((ProfileDetails) -> Void)?
    
    //MARK: - Private variables
    private let session = MockURLSession()
    
    //MARK: - Actions
    func callAsFunction(_ action: ProfileActions) {
        switch action {
        case .profileDetails(let username): getProfileDetails(username)
        }
    }
    
    //MARK: - Private methods
    private func getProfileDetails(_ username: String) {
        session.testDataJSONFile = "profile_details"
        let api                  = UserDataAPIServices.profileDetails(username)
        let router               = APIRouter<ProfileDetailsResponse>(session: session)
        router.requestData(api) { [weak self] (output, statusCode, error) in
            guard let self else {return}
            if let data = output?.data {
                self.profileDataCallback?(data)
            } else {
                self.errorCallback?(error?.localizedDescription)
            }
        }
    }
    
    
}
