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
        let count = self.presenter?.getModelsCount()
        return 0 == count ? 10 : count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard 0 < self.presenter?.getModelsCount() ?? 0 else {
            return self.handleMockCell(collectionView: collectionView, indexPath: indexPath)
        }
        
        return self.handleContentCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    private func handleContentCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
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
    
    private func handleMockCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MockupCollectionViewCell.reuseIdentifier,
                                                                         for: indexPath)
        return cell
    }
}
