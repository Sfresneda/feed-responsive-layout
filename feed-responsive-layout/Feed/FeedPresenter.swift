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
    private lazy var isLoading: Bool = false
    weak var view: FeedViewContract?
    
    // MARK: - Contract
    
    func getModelsCount() -> Int {
        return self.models.count
    }
    
    func getModelFor(row: Int) -> FeedCellModel? {
        guard 0 <= row, self.models.count >= row else {
            return nil
        }
        return self.models[row]
    }
    
    func loadMoreData(cleanPrevious: Bool) {
        if cleanPrevious { self.models.removeAll() }
        self.isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let newModels = self.addModels()
            newModels.forEach({ model in
                self.models.append(model)
            })

            self.isLoading = false
            let rowIndex: [Int] = Array((self.models.count - newModels.count)..<self.models.count)
            let indexPathArray: [IndexPath] = rowIndex.compactMap({ row -> IndexPath in
                IndexPath.init(row: row, section: 0)
            })
            self.view?.stopRefreshControll()
            self.view?.addCellsToCollection(with: indexPathArray)
        }
    }
    
    func isCollectionLoading() -> Bool {
        return self.isLoading
    }
    
    func shouldAppearLoadingMock() -> Bool {
        return self.isLoading && self.models.isEmpty
    }
    
    // MARK: - Helpers
    private func addModels() -> [FeedCellModel] {
        var newModels: [FeedCellModel] = []
        for index in 0...9 {
            newModels.append(FeedCellModel.init(name: "Cell \(String(index))"))
        }
        return newModels
    }
}

