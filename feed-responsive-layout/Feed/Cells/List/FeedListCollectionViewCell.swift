//
//  FeedListCollectionViewCell.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import UIKit

protocol FeedListCellContract {
    func setModel(_ model: FeedCellModel)
}

class FeedListCollectionViewCell: UICollectionViewCell {
        
    // MARK: - Vars
    private var model: FeedCellModel? {
        didSet {
            self.setNeedsLayout()
        }
    }
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setupCell()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bindCell()
    }
    
    // MARK: - Setup
    private func setupCell() {
        self.backgroundColor = UIColor.clear
    }
    
    private func bindCell() {
        self.backgroundColor = UIColor.init(red: CGFloat.random(in: ClosedRange<CGFloat>.init(uncheckedBounds: (lower: 0, upper: 255)))/255,
                                            green: CGFloat.random(in: ClosedRange<CGFloat>.init(uncheckedBounds: (lower: 0, upper: 255)))/255,
                                            blue: CGFloat.random(in: ClosedRange<CGFloat>.init(uncheckedBounds: (lower: 0, upper: 255)))/255,
                                            alpha: 1)
    }
    // MARK: - Actions
    
    // MARK: - Helpers
    
}

// MARK: - Contract
extension FeedListCollectionViewCell: FeedListCellContract {
    func setModel(_ model: FeedCellModel) {
        self.model = model
    }
}


