//
//  MockupGridCollectionViewCell.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/27/20.
//

import UIKit

class MockupGridCollectionViewCell: MockBaseCollectionViewCell {
    
    // MARK: - UI
    private weak var contentMock: UIView!
    
    // MARK: - Vars
    private lazy var isAnimated: Bool = false

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
        self.resetAnimation()
        self.subviews.forEach({ $0.removeFromSuperview() })

        self.addUIElements()
    }
    
    private func bindCell() {
        self.contentMock.layer.cornerRadius = 10
        self.contentMock.clipsToBounds = true
        self.addGradient(on: self.contentMock)
        
        self.animateCell()
    }
    
    // MARK: - Helpers
    private func addUIElements() {
        let contentMock = UIView.init()
        self.contentMock = contentMock

        self.addSubview(contentMock)
        self.updateConstraints()
    }
    
    private func addConstraints() {
        let guide = self.safeAreaLayoutGuide
        
        self.contentMock.translatesAutoresizingMaskIntoConstraints = false
        self.contentMock.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 0.9).isActive = true
        self.contentMock.leadingAnchor.constraint(equalToSystemSpacingAfter: guide.leadingAnchor, multiplier: 0.9).isActive = true
        guide.trailingAnchor.constraint(equalToSystemSpacingAfter: self.contentMock.trailingAnchor, multiplier: 0.9).isActive = true
        guide.bottomAnchor.constraint(equalToSystemSpacingBelow: self.contentMock.bottomAnchor, multiplier: 0.9).isActive = true
    }
}

