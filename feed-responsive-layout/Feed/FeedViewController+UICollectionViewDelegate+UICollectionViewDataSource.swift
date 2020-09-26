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
        return self.presenter?.getModelsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let flowLayout = collectionView.collectionViewLayout as? FeedFlowLayout else { fatalError() }
        
        var cell: FeedCellContract
        
        switch flowLayout.layoutType {
        case .grid:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedGridCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! FeedCellContract
        case .list:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedListCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! FeedCellContract
        }
        
        guard let model = self.presenter?.getModelFor(row: indexPath.row) else {
            fatalError()
        }
        cell.setModel(model)
        
        return cell
    }
}
