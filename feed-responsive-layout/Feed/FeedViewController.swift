//
//  FeedViewController.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import UIKit

class FeedViewController: UIViewController, FeedViewContract {
    
    // MARK: - UI
    private weak var scrollView: UIScrollView!
    private weak var listCollectionView: UICollectionView!
    private weak var listRefreshControl: UIRefreshControl!
    
    private weak var gridCollectionView: UICollectionView!
    private weak var gridRefreshControl: UIRefreshControl!
    
    
    
    // MARK: - Vars
    var presenter: FeedPresenterContract?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.loadMoreData(cleanPrevious: true)
    }
    
    // MARK: - Setup
    private func setupView() {
        self.addUIElements()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.listCollectionView.delegate = self
        self.listCollectionView.dataSource = self
        
        self.gridCollectionView.delegate = self
        self.gridCollectionView.dataSource = self
        
        self.registerCells()
    }
    
    // MARK: - Contract
    func newDataIsLoaded() {
        self.listRefreshControl.endRefreshing()
        self.gridRefreshControl.endRefreshing()
        
        self.listCollectionView.reloadData()
        self.gridCollectionView.reloadData()
    }
    
    func addCellsToCollection(with index: [IndexPath]) {
        DispatchQueue.main.async {
            self.listCollectionView.performBatchUpdates ({
                self.listCollectionView.insertItems(at: index)
            }, completion: nil)
            self.gridCollectionView.performBatchUpdates ({
                self.gridCollectionView.insertItems(at: index)
            }, completion: nil)
        }
    }
    func stopRefreshControll() {
        self.listRefreshControl.endRefreshing()
        self.gridRefreshControl.endRefreshing()
    }
    
    // MARK: - Actions
    @objc
    private func refreshControlDidStart(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        self.presenter?.loadMoreData(cleanPrevious: true)
    }
    
    // MARK: - Helper
    
    private func addUIElements() {
        let scrollView = UIScrollView.init()
        self.scrollView = scrollView
        self.scrollView.backgroundColor = UIColor.white
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        
        let listLayout = FeedFlowLayout.init(layoutType: .list)
        let listCollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: listLayout)
        self.listCollectionView = listCollectionView
        self.listCollectionView.backgroundColor = UIColor.clear
        
        let gridLayout = FeedFlowLayout.init(layoutType: .grid)
        let gridCollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: gridLayout)
        self.gridCollectionView = gridCollectionView
        self.gridCollectionView.backgroundColor = UIColor.clear
        
        let listRefreshControl = UIRefreshControl.init()
        self.listRefreshControl = listRefreshControl
        self.listRefreshControl.tintColor = UIColor.red
        self.listRefreshControl.addTarget(self, action: #selector(refreshControlDidStart(_:)), for: .valueChanged)
        self.listCollectionView.refreshControl = listRefreshControl
        
        let gridRefreshControl = UIRefreshControl.init()
        self.gridRefreshControl = gridRefreshControl
        self.gridRefreshControl.tintColor = UIColor.red
        self.gridRefreshControl.addTarget(self, action: #selector(refreshControlDidStart(_:)), for: .valueChanged)
        self.gridCollectionView.refreshControl = gridRefreshControl
        
        self.view.addSubview(scrollView)
        self.addCollectionToScroll(collections: [listCollectionView, gridCollectionView])
    }
    
    private func addCollectionToScroll(collections: [UICollectionView]) {
        self.scrollView.contentSize = CGSize.init(width: self.view.bounds.width * CGFloat(collections.count),
                                                  height: self.view.bounds.height)
        
        collections.forEach({ collection in
            collection.frame = CGRect.init(x: self.view.bounds.width * CGFloat(self.scrollView.subviews.count),
                                           y: 0,
                                           width: self.view.bounds.width,
                                           height: self.view.bounds.height)
            self.scrollView.addSubview(collection)
        })
        
        self.updateViewConstraints()
    }
    
    private func registerCells() {
        self.listCollectionView.register(FeedListCollectionViewCell.self,
                                         forCellWithReuseIdentifier: FeedListCollectionViewCell.reuseIdentifier)
        
        self.gridCollectionView.register(FeedGridCollectionViewCell.self,
                                         forCellWithReuseIdentifier: FeedGridCollectionViewCell.reuseIdentifier)
        
        self.listCollectionView.register(MockupListCollectionViewCell.self,
                                         forCellWithReuseIdentifier: MockupListCollectionViewCell.reuseIdentifier)
        self.gridCollectionView.register(MockupGridCollectionViewCell.self,
                                         forCellWithReuseIdentifier: MockupGridCollectionViewCell.reuseIdentifier)
        
    }
}

// MARK: - UIScrollViewDelegate
extension FeedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        debugPrint(scrollView.contentOffset.x)
    }
}

// MARK: - Constraints
extension FeedViewController {
    private func addConstraints() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
