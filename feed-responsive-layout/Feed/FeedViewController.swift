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
    private weak var listCollectionView: UIView!
    private weak var gridCollectionView: UIView!
    
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

    }
    
    private func setupCollectionView() {
        
    }
    
    // MARK: - Contract
    
    // MARK: - Actions
    
    // MARK: - Helper
    
}

// MARK: - UIScrollViewDelegate
extension FeedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        debugPrint(scrollView.contentOffset.y)
    }
}

// MARK: - Constraints
extension FeedViewController {
    private func addConstraints() {
        
    }
}
