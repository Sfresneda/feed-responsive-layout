//
//  MockBaseCollectionViewCell.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/27/20.
//

import UIKit

class MockBaseCollectionViewCell: UICollectionViewCell {
    private lazy var isAnimated: Bool = false

    func resetAnimation() {
        self.isAnimated = false
    }
    
    func animateCell() {
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
    
    func addGradient(on view: UIView) {
        let layer = CAGradientLayer.init(start: .topLeft,
                                         end: .bottomRight,
                                         colors: [UIColor.systemGray4.cgColor,
                                                  UIColor.white.cgColor],
                                         type: .axial)
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }
}
