//
//  FeedCellModel.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import Foundation

struct FeedCellModel: Hashable {
    let identifier: UUID = UUID.init()
    let name: String
    let cellColor: CellColor = CellColor.init()
    let cellHeight: Float = Float.random(in: ClosedRange<Float>.init(uncheckedBounds: (lower: 200, upper: 600)))
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }

    static func == (lhs: FeedCellModel, rhs: FeedCellModel) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

struct CellColor {
    let red: Float = Float.random(in: ClosedRange<Float>.init(uncheckedBounds: (lower: 0, upper: 255)))/255
    let green: Float = Float.random(in: ClosedRange<Float>.init(uncheckedBounds: (lower: 0, upper: 255)))/255
    let blue: Float = Float.random(in: ClosedRange<Float>.init(uncheckedBounds: (lower: 0, upper: 255)))/255
    
    
}
