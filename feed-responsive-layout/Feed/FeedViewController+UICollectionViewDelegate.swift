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
        
        let lastIndexOffset = collectionView.numberOfItems(inSection: 0) - 1
        guard !(self.presenter?.isCollectionLoading() ?? true),
              lastIndexOffset <= indexPath.row else {
            return
        }

        self.presenter?.loadMoreData(clear: false)
    }
}

extension FeedViewController: FeedFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let model = self.presenter?.getModelFor(row: indexPath.row) else { fatalError() }
        return CGFloat(model.cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, cellContainsAdAtIndexPath indexPath: IndexPath) -> Bool {
        let row = indexPath.row + 1
        return row % 5 == 0 && row != 0
    }
    func collectionView(_ collectionView: UICollectionView, heightForAdAtIndexPath indexPath: IndexPath) -> CGFloat {
        let collectionWidth = collectionView.bounds.width
        return 500 >= collectionWidth ? collectionWidth : 500
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
