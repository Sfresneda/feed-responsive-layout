//
//  FeedListCollectionViewCell.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import UIKit

class FeedListCollectionViewCell: UICollectionViewCell {
        
    // MARK: - UI
    private weak var titleLabel: UILabel!
    private weak var adView: UIView?

    // MARK: - Vars
    private lazy var containsAd: Bool = false
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
    override func updateConstraints() {
        super.updateConstraints()
        self.addConstraints()
    }
    
    // MARK: - Setup
    private func setupCell() {
        self.backgroundColor = UIColor.clear
        self.subviews.forEach({ $0.removeFromSuperview() })

        self.addUIElements()
    }
    
    private func bindCell() {
        guard let model = self.model else { fatalError() }
        
        self.backgroundColor = UIColor.init(red: CGFloat(model.cellColor.red),
                                            green: CGFloat(model.cellColor.green),
                                            blue: CGFloat(model.cellColor.blue),
                                            alpha: 1)
        self.titleLabel.text = model.name
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    private func addUIElements() {
        let titleLabel = UILabel.init()
        self.titleLabel = titleLabel
        self.titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.titleLabel.textAlignment = .center
        
        self.addSubview(titleLabel)
        self.updateConstraints()
    }
    
    private func addConstraints() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}

// MARK: - Contract
extension FeedListCollectionViewCell: FeedCellContract {
    func setModel(_ model: FeedCellModel) {
        self.model = model
    }
}


