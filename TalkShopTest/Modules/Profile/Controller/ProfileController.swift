//
//  ProfileController.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 17/02/24.
//

import UIKit

class ProfileController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var feedHeaderContainerView: UIView! {
        didSet {
            feedHeaderContainerView.alpha = 0.0
        }
    }
    @IBOutlet weak var usernameLabel: UILabel! {
        didSet {
            usernameLabel.alpha = 0.0
        }
    }
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.cornerRadius(profileImageView.bounds.height * 0.5)
            profileImageView.border(1.0, .white)
            profileImageView.alpha = 0.0
        }
    }
    @IBOutlet weak var feedCollectionView: UICollectionView! {
        didSet {
            feedCollectionView.delegate = self
            feedCollectionView.dataSource = self
            
            feedCollectionView.register(UINib(nibName: "ProfileFeedCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ProfileFeedCollectionCell")
        }
    }
    
    //MARK: - Private variables
    private let viewModel = ProfileViewModel()
    private var profileDetails: ProfileDetails? = nil
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileData()
    }
    
    //MARK: - Private methods
    private func setProfileData() {
        guard let data = profileDetails else {return}
        profileImageView.image = UIImage(named: data.profilePictureUrl)
        usernameLabel.text = "@\(data.username)"
        profileImageView.fadeIn()
        usernameLabel.fadeIn()
        feedHeaderContainerView.fadeIn()
    }
    
    //MARK: - Button actions
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}

//MARK: - API calls
extension ProfileController {
    
    private func getProfileData() {
        showActivityIndicator()
        
        viewModel(.profileDetails("kamikaze"))
        
        viewModel.profileDataCallback = { [weak self] profileDetails in
            guard let self else {return}
            self.profileDetails = profileDetails
            DispatchQueue.main.async {
                self.setProfileData()
                self.feedCollectionView.reloadData()
                self.hideActivityIndicator()
            }
        }
        
        viewModel.errorCallback = { [weak self] message in
            guard let self, let message = message else {return}
            self.alert("Profile Details", message)
            self.hideActivityIndicator()
        }
    }
}

//MARK: - Naviagtions
extension ProfileController {
    func pushToPostDetailsScreen(_ feedData: HomeFeed) {
        let controller = PostDetailsController(feedData)
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: Collection View
extension ProfileController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.fadeIn()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.bounce({ [weak self] in
            guard let self,
                  let feedData = self.profileDetails?.posts[indexPath.item] else {return}
            self.pushToPostDetailsScreen(feedData)
        })
    }
    
}

extension ProfileController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileDetails?.posts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileFeedCollectionCell", for: indexPath) as! ProfileFeedCollectionCell
        
        cell.feedData = profileDetails?.posts[indexPath.item]
        
        return cell
    }
    
}

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.bounds.width / 3
        return CGSize(width: width, height: width * 1.2)
    }
}
