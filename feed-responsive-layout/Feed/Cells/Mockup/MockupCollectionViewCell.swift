//
//  MockupCollectionViewCell.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import UIKit

class MockupCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI
    private weak var profileImageMock: UIView!
    private weak var authorMock: UIView!
    private weak var contentMock: UIView!
    private weak var footerMock: UIView!
    
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
        self.isAnimated = false
        self.subviews.forEach({ $0.removeFromSuperview() })

        self.addUIElements()
    }
    
    private func bindCell() {
        self.profileImageMock.layer.cornerRadius = self.profileImageMock.bounds.width * 0.5
        self.profileImageMock.clipsToBounds = true
        
        self.authorMock.layer.cornerRadius = 20
        self.authorMock.clipsToBounds = true
        
        self.contentMock.layer.cornerRadius = 20
        self.authorMock.clipsToBounds = true
        
        self.footerMock.layer.cornerRadius = 20
        self.footerMock.clipsToBounds = true
        
        self.animateCell()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    private func addUIElements() {
        let profileImageMock = UIView.init()
        self.profileImageMock = profileImageMock
        self.profileImageMock.backgroundColor = UIColor.lightGray
        
        let authorMock = UIView.init()
        self.authorMock = authorMock
        self.authorMock.backgroundColor = UIColor.lightGray
        
        let contentMock = UIView.init()
        self.contentMock = contentMock
        self.contentMock.backgroundColor = UIColor.lightGray
        
        let footerMock = UIView.init()
        self.footerMock = footerMock
        self.footerMock.backgroundColor = UIColor.lightGray
        
        self.addSubview(profileImageMock)
        self.addSubview(authorMock)
        self.addSubview(contentMock)
        self.addSubview(footerMock)
        
        self.updateConstraints()
    }
    
    private func addConstraints() {
        let guide = self.safeAreaLayoutGuide
        
        self.profileImageMock.translatesAutoresizingMaskIntoConstraints = false
        self.profileImageMock.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10).isActive = true
        self.profileImageMock.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
        self.profileImageMock.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.profileImageMock.heightAnchor.constraint(equalTo: self.profileImageMock.widthAnchor).isActive = true
        
        self.authorMock.translatesAutoresizingMaskIntoConstraints = false
        self.authorMock.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10).isActive = true
        self.authorMock.leadingAnchor.constraint(equalTo: self.profileImageMock.trailingAnchor, constant: 10).isActive = true
        guide.trailingAnchor.constraint(equalTo: self.authorMock.trailingAnchor, constant: 10).isActive = true
        self.authorMock.heightAnchor.constraint(equalTo: self.profileImageMock.heightAnchor).isActive = true
        
        self.contentMock.translatesAutoresizingMaskIntoConstraints = false
        self.contentMock.topAnchor.constraint(equalTo: profileImageMock.bottomAnchor, constant: 10).isActive = true
        self.contentMock.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
        guide.trailingAnchor.constraint(equalTo: self.contentMock.trailingAnchor, constant: 10).isActive = true
        
        self.footerMock.translatesAutoresizingMaskIntoConstraints = false
        self.footerMock.topAnchor.constraint(equalTo: self.contentMock.bottomAnchor, constant: 10).isActive = true
        self.footerMock.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
        guide.trailingAnchor.constraint(equalTo: self.footerMock.trailingAnchor, constant: 10).isActive = true
        self.footerMock.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        self.footerMock.heightAnchor.constraint(equalTo: self.profileImageMock.heightAnchor).isActive = true
    }
    
    private func animateCell() {
        guard !isAnimated else { return }
        self.isAnimated = true
        
        let fadeAnimation = CAKeyframeAnimation(keyPath:"opacity")
        fadeAnimation.duration = 2
        fadeAnimation.keyTimes = [0, 0.2, 0.6, 1]
        fadeAnimation.values = [0.0, 1.0, 1.0, 0.0]
        fadeAnimation.isRemovedOnCompletion = false
        fadeAnimation.repeatCount = .infinity
        fadeAnimation.autoreverses = false
        fadeAnimation.fillMode = CAMediaTimingFillMode.forwards
        layer.add(fadeAnimation, forKey:"animateOpacity")
        layer.opacity = 0.0
    }
}
