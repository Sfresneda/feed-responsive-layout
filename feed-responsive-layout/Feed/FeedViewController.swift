//
//  FeedViewController.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import UIKit

enum FeedSection {
  case main
}

class FeedViewController: UIViewController, FeedViewContract {
    
    // MARK: - UI
    private weak var scrollView: UIScrollView!
    private(set) weak var listCollectionView: UICollectionView!
    private weak var listRefreshControl: UIRefreshControl!
    
    private(set) weak var gridCollectionView: UICollectionView!
    private weak var gridRefreshControl: UIRefreshControl!
    
    // MARK: - Vars
    private(set) lazy var gridDataSource: FeedDataSource = self.setupCollectionDatasource(type: .grid)
    private(set) lazy var listDataSource: FeedDataSource = self.setupCollectionDatasource(type: .list)
    var presenter: FeedPresenterContract?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter?.loadMoreData(clear: true)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Setup
    private func setupView() {
        self.addUIElements()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.listCollectionView.delegate = self
        self.listCollectionView.dataSource = self.listDataSource
        
        self.gridCollectionView.delegate = self
        self.gridCollectionView.dataSource = self.gridDataSource
        
        self.registerCells()
    }
    
    // MARK: - Contract
    func newDataIsLoaded(with snapshot: FeedSnapshot) {
        self.stopRefreshControll()
        
        self.gridDataSource.apply(snapshot, animatingDifferences: true)
        self.listDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func stopRefreshControll() {
        self.listRefreshControl.endRefreshing()
        self.gridRefreshControl.endRefreshing()
    }
    
    // MARK: - Actions
    @objc
    private func refreshControlDidStart(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        self.presenter?.loadMoreData(clear: true)
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
    }
}

// MARK: - UIScrollViewDelegate
extension FeedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
