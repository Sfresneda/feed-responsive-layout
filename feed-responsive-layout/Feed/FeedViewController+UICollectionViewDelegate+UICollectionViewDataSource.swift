//
//  FeedViewController+UICollectionViewDelegate+UICollectionViewDataSource.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import UIKit

// MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.2) {
            cell.alpha = 1
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.presenter?.getModelsCount() ?? 0
        return self.presenter?.shouldAppearLoadingMock() ?? false ? 1 : count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard !(self.presenter?.shouldAppearLoadingMock() ?? false) else {
            return self.handleMockCell(collectionView: collectionView, indexPath: indexPath)
        }
        
        return self.handleContentCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    // MARK: - Helpers
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
        guard let flowLayout = collectionView.collectionViewLayout as? FeedFlowLayout else { fatalError() }

        var cell: UICollectionViewCell
        
        switch flowLayout.layoutType {
        case .grid:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: MockupGridCollectionViewCell.reuseIdentifier,
                                                      for: indexPath)
        case .list:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: MockupListCollectionViewCell.reuseIdentifier,
                                                      for: indexPath)
        }

        return cell
    }
}
