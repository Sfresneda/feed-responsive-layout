//
//  FeedViewController+UICollectionViewDelegate+UICollectionViewDataSource.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import UIKit

typealias FeedDataSource = UICollectionViewDiffableDataSource<FeedSection, FeedCellModel>
typealias FeedSnapshot = NSDiffableDataSourceSnapshot<FeedSection, FeedCellModel>

// MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.2) {
            cell.alpha = 1
        }
        
        let lastIndexOffset = collectionView.numberOfItems(inSection: 0) - 3
        guard !(self.presenter?.isCollectionLoading() ?? true),
              lastIndexOffset <= indexPath.row else {
            return
        }

        self.presenter?.loadMoreData(clear: false)
    }
}

extension FeedViewController {
    func setupCollectionDatasource(type: FeedLayoutType) -> FeedDataSource {
        switch type {
        case .grid:
            return FeedDataSource.init(collectionView: self.gridCollectionView) {
                (collectionView, indexPath, model) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedGridCollectionViewCell.reuseIdentifier,
                                                              for: indexPath) as? FeedCellContract
                cell?.setModel(model)
                return cell
            }
            
        case .list:
            return FeedDataSource.init(collectionView: self.listCollectionView) {
                (collectionView, indexPath, model) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedListCollectionViewCell.reuseIdentifier,
                                                              for: indexPath) as? FeedCellContract
                cell?.setModel(model)
                return cell
            }
        }
    }
}
