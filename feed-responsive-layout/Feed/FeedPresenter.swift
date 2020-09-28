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
    
    func loadMoreData(clear: Bool) {
        if clear { self.models.removeAll() }
        self.view?.stopRefreshControll()
        self.isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let newModels = self.addModels()
            newModels.forEach({ model in
                self.models.append(model)
            })
            
            self.applySnapshot()
            self.isLoading = false
        }
    }
    
    func isCollectionLoading() -> Bool {
        return self.isLoading
    }
    
    func shouldAppearLoadingMock() -> Bool {
        return self.isLoading && self.models.isEmpty
    }
    
    // MARK: - Helpers
    private func applySnapshot() {
        var snapshot = FeedSnapshot.init()
        snapshot.appendSections([FeedSection.main])
        snapshot.appendItems(self.models, toSection: .main)
        
        self.view?.newDataIsLoaded(with: snapshot)
    }
    
    private func addModels() -> [FeedCellModel] {
        var newModels: [FeedCellModel] = []
        for index in 0...20 {
            newModels.append(FeedCellModel.init(name: "Cell \(String(index))"))
        }
        return newModels
    }
}

