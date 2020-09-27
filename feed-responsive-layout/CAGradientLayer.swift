//
//  CAGradientLayer.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/27/20.
//

import UIKit

extension CAGradientLayer {
    enum Point {
        case topLeft
        case topMidCenterLeft
        case bottomMidCenterLeft
        case centerLeft
        case bottomLeft
        case topCenter
        case center
        case bottomCenter
        case topRight
        case topMidCenterRight
        case bottomMidCenterRight
        case centerRight
        case bottomRight
        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .topMidCenterLeft:
                return CGPoint(x: 0, y: 0.25)
            case .bottomMidCenterLeft:
                return CGPoint(x: 0, y: 0.75)
            case .centerLeft:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeft:
                return CGPoint(x: 0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottomCenter:
                return CGPoint(x: 0.5, y: 1.0)
            case .topRight:
                return CGPoint(x: 1.0, y: 0.0)
            case .topMidCenterRight:
                return CGPoint(x: 1.0, y: 0.25)
            case .bottomMidCenterRight:
                return CGPoint(x: 1.0, y: 0.75)
            case .centerRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    convenience init(start: Point, end: Point, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}

