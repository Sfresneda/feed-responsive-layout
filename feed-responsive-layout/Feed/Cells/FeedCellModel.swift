//
//  FeedCellModel.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import Foundation

struct FeedCellModel {
    let name: String
    let cellColor: CellColor = CellColor.init()
}

struct CellColor {
    let red: Float = Float.random(in: ClosedRange<Float>.init(uncheckedBounds: (lower: 0, upper: 255)))/255
    let green: Float = Float.random(in: ClosedRange<Float>.init(uncheckedBounds: (lower: 0, upper: 255)))/255
    let blue: Float = Float.random(in: ClosedRange<Float>.init(uncheckedBounds: (lower: 0, upper: 255)))/255
    
    
}
