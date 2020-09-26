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
    private weak var gridCollectionView: UICollectionView!
    
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
    
    // MARK: - Setup
    private func setupView() {
        self.addUIElements()
    }
    
    private func setupCollectionView() {
        
    }
    
    // MARK: - Contract
    
    // MARK: - Actions
    
    // MARK: - Helper
    private func addUIElements() {
        let scrollView = UIScrollView.init()
        self.scrollView = scrollView
        self.scrollView.backgroundColor = UIColor.white
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        
        let listLayout = UICollectionViewLayout.init()
        let listCollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: listLayout)
        self.listCollectionView = listCollectionView
        self.listCollectionView.backgroundColor = UIColor.systemTeal
        
        let gridLayout = UICollectionViewLayout.init()
        let gridCollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: gridLayout)
        self.gridCollectionView = gridCollectionView
        self.gridCollectionView.backgroundColor = UIColor.systemFill
        
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
