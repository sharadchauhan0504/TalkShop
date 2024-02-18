//
//  HomeScreenController.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 15/02/24.
//

import UIKit

class HomeScreenController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var feedCollectionView: UICollectionView! {
        didSet {
            feedCollectionView.delegate = self
            feedCollectionView.dataSource = self
            
            feedCollectionView.register(UINib(nibName: "HomeFeedCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeFeedCollectionCell")
            feedCollectionView.addSubview(refreshControl)
        }
    }
    
    //MARK: - Private variables
    private let viewModel = HomeScreenViewModel()
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .white
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return control
    }()
    
    //MARK: Lifecycle methods
    public init() {
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFeedData(false)
    }
    
    //MARK: - Button action
    @IBAction func profileButtonAction(_ sender: UIButton) {
        pushToProfileScreen()
    }
    
}

//MARK: - API calls
extension HomeScreenController {
    
    private func fetchFeedData(_ isFromPullToRefresh: Bool) {
        
        if !isFromPullToRefresh {
            showActivityIndicator()
        }
        
        viewModel(.feedData)
        viewModel.feedDataCallback = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.feedCollectionView.reloadData()
                self.hideActivityIndicator()
            }
        }
        
        viewModel.errorCallback = { [weak self] message in
            guard let self, let message = message else {return}
            self.alert("Feed Data", message)
            self.hideActivityIndicator()
        }
    }
    
    @objc func refreshData() {
        fetchFeedData(true)
    }
    
    private func postDetails(_ id: String) {
        showActivityIndicator()
        viewModel(.postDetails(id))
        viewModel.postDetailsCallback = { [weak self] postData in
            guard let self, let feedData = postData else {return}
            DispatchQueue.main.async {
                self.pushToPostDetailsScreen(feedData)
                self.hideActivityIndicator()
            }
        }
        
        viewModel.errorCallback = { [weak self] message in
            guard let self, let message = message else {return}
            self.alert("Post Details", message)
            self.hideActivityIndicator()
        }
    }
}

//MARK: - Naviagtions
extension HomeScreenController {
    
    func pushToProfileScreen() {
        let controller = ProfileController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func pushToPostDetailsScreen(_ feedData: HomeFeed) {
        let controller = PostDetailsController(feedData)
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: Collection View
extension HomeScreenController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.fadeIn()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.bounce({ [weak self] in
            guard let self else {return}
            let postId = self.viewModel.feedData[indexPath.item].postId
            self.postDetails(postId)
        })
    }
    
}

extension HomeScreenController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.feedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeFeedCollectionCell", for: indexPath) as! HomeFeedCollectionCell
        cell.feedData = viewModel.feedData[indexPath.item]
        return cell
    }
    
}

extension HomeScreenController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.bounds.width / 2
        return CGSize(width: width, height: width * 1.5)
    }
}
