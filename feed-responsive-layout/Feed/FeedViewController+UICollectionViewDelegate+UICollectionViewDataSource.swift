//
//  FeedViewController+UICollectionViewDelegate+UICollectionViewDataSource.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import UIKit

extension FeedViewController: UICollectionViewDelegate {
    
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedListCollectionViewCell.reuseIdentifier,
                                                            for: indexPath)
        
        return cell
    }
}
