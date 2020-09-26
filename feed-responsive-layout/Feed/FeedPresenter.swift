//
//  FeedPresenter.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import Foundation

class FeedPresenter: FeedPresenterContract {
    
    // MARK: - Vars
    private lazy var models: [FeedCellModel] = []
    weak var view: FeedViewContract?
    
    // MARK: - Contract
    func initModels() {
        self.bindModelsArray()
    }
    
    func getModelsCount() -> Int {
        return self.models.count
    }
    
    func getModelFor(row: Int) -> FeedCellModel? {
        guard 0 <= row, self.models.count >= row else {
            return nil
        }
        return self.models[row]
    }
    
    // MARK: - Helpers
    private func bindModelsArray() {
        for index in 0...100 {
            self.models.append(FeedCellModel.init(name: "Cell \(String(index))"))
        }
    }
}

