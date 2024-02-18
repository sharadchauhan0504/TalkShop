//
//  PostDetailsController.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 17/02/24.
//

import UIKit
import AVFoundation

class PostDetailsController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var videoPlayerContainer: UIView! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            tapGesture.numberOfTapsRequired = 2
            videoPlayerContainer.addGestureRecognizer(tapGesture)
        }
    }
    @IBOutlet weak var profilePictureImageView: UIImageView! {
        didSet {
            profilePictureImageView.cornerRadius(profilePictureImageView.bounds.height * 0.5)
            profilePictureImageView.border(1.0, .white)
        }
    }
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var likesImageView: UIImageView!
    
    //MARK: - Private variables
    private var feedData: HomeFeed? = nil
    private var player: AVPlayer!
    private var isPostLiked = false
    
    //MARK: Lifecycle methods
    public init() {
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ feedData: HomeFeed) {
        self.init()
        self.feedData = feedData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPostDetails()
    }
    
    //MARK: - Private methods
    private func setPostDetails() {
        guard let feed = feedData else {return}
        posterImageView.image = UIImage(named: feed.thumbnailURL)
        usernameLabel.text = "@\(feed.username)"
        profilePictureImageView.image = UIImage(named: feed.profilePictureUrl)
        playVideo(feed.videoUrl)
        numberOfLikesLabel.text = "\(feed.likes)"
    }
    
    //MARK: - Button actions
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        manageLikeCounter()
    }
    
    
    //MARK: - Deinit
    deinit {
        debugPrint("PostDetailsController: deinit")
        player.removeObserver(self, forKeyPath: #keyPath(AVPlayer.status))
    }
}

//MARK: - Tap gesture
extension PostDetailsController {
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        manageLikeCounter()
    }
    
    private func manageLikeCounter() {
        isPostLiked = !isPostLiked
        if isPostLiked {
            numberOfLikesLabel.text = "\((feedData?.likes ?? 0) + 1)"
            likesImageView.image = UIImage(systemName: "heart.fill")
        } else {
            numberOfLikesLabel.text = "\(feedData?.likes ?? 0)"
            likesImageView.image = UIImage(systemName: "heart")
        }
    }

}

//MARK: - Player
extension PostDetailsController {
    
    private func playVideo(_ file:String) {
        let file = file.components(separatedBy: ".")
        guard let path = Bundle.main.path(forResource: file[0], ofType: file[1]) else {
            debugPrint( "\(file.joined(separator: ".")) not found")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        videoPlayerContainer.layer.addSublayer(playerLayer)
        player.addObserver(self, forKeyPath: #keyPath(AVPlayer.status), options: [.new, .initial], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayer.status) {
            if let newStatusValue = change?[.newKey] as? Int,
               let newStatus = AVPlayer.Status(rawValue: newStatusValue) {
                switch newStatus {
                case .readyToPlay:
                    posterImageView.fadeOut()
                    videoPlayerContainer.fadeIn()
                    player.play()
                case .failed:
                    print("AVPlayer status failed")
                default:
                    break
                }
            }
        }
    }
    
}
