//
//  FeedGridCollectionViewCell.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import UIKit

class FeedGridCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    private func bindCell() {
        guard let model = self.model else { fatalError() }
        self.backgroundColor = UIColor.init(red: CGFloat(model.cellColor.red),
                                            green: CGFloat(model.cellColor.green),
                                            blue: CGFloat(model.cellColor.blue),
                                            alpha: 1)
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
}

// MARK: - Contract
extension FeedGridCollectionViewCell: FeedCellContract {
    func setModel(_ model: FeedCellModel) {
        self.model = model
    }
}


