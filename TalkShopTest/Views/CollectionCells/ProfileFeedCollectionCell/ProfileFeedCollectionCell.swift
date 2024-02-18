//
//  ProfileFeedCollectionCell.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 17/02/24.
//

import UIKit

class ProfileFeedCollectionCell: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var likesBackgroundView: UIView! {
        didSet {
            likesBackgroundView.cornerRadius(likesBackgroundView.bounds.height * 0.5)
        }
    }
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var gradientContainerView: UIView!
    
    //MARK: - Public variables
    var feedData: HomeFeed? = nil {
        didSet {
            setFeedData()
        }
    }
    
    //MARK: - Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    //MARK: Private methods
    private func setFeedData() {
        guard let feed = feedData else {return}
        posterImageView.image = UIImage(named: feed.thumbnailURL)
        numberOfLikesLabel.text = "❤️ \(feed.likes)"
    }

}
