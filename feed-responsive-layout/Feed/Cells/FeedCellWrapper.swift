//
//  FeedCellWrapper.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import UIKit

protocol FeedCellContract where Self: UICollectionViewCell {
    func setModel(_ model: FeedCellModel)
}
