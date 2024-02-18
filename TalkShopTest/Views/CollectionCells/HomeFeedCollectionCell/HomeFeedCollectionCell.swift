//
//  HomeFeedCollectionCell.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 16/02/24.
//

import UIKit

class HomeFeedCollectionCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var likesBackgroundView: UIView! {
        didSet {
            likesBackgroundView.cornerRadius(likesBackgroundView.bounds.height * 0.5)
        }
    }
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var gradientContainerView: UIView! {
        didSet {
            let blackColor = UIColor.black.cgColor
            let clearColor = UIColor.clear.cgColor
            gradientContainerView.addGradient([blackColor, clearColor], [0.0, 0.2])
        }
    }
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.cornerRadius(16.0)
        }
    }
    
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
        usernameLabel.text = "@\(feed.username)"
    }
    
}
