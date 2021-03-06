//
//  FeedContract.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import Foundation
protocol FeedViewContract: AnyObject {
    var presenter: FeedPresenterContract? { get set }
    
    func newDataIsLoaded(with snapshot: FeedSnapshot)
    func stopRefreshControll()
}

protocol FeedPresenterContract: AnyObject {
    var view: FeedViewContract? { get set }
    
    func getModelsCount() -> Int
    func getModelFor(row: Int) -> FeedCellModel?
    func loadMoreData(clear: Bool)
    func isCollectionLoading() -> Bool
    func shouldAppearLoadingMock() -> Bool
}

