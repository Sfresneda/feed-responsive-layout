//
//  FeedContract.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import Foundation
protocol FeedViewContract: AnyObject {
    var presenter: FeedPresenterContract? { get set }
    
}

protocol FeedPresenterContract: AnyObject {
    var view: FeedViewContract? { get set }
    
    func initModels()
    func getModelsCount() -> Int
    func getModelFor(row: Int) -> FeedCellModel?
}

