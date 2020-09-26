//
//  FeedFlowLayout.swift
//  feed-responsive-layout
//
//  Created by Sergio Fresneda on 9/26/20.
//

import UIKit

enum FeedLayoutType {
    case list
    case grid
    
    var cellsPerRow: Int {
        switch self {
        case .list:
            return 1
        case .grid:
            return 3
        }
    }
}

class FeedFlowLayout: UICollectionViewFlowLayout {
    private var layoutType: FeedLayoutType = .list
    
    init(layoutType: FeedLayoutType) {
        super.init()
        self.layoutType = layoutType
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        
        self.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.minimumInteritemSpacing = .list == self.layoutType ? 0 : 1
        self.minimumLineSpacing = .list == self.layoutType ? 0 : 1
        
        let insets = self.sectionInset.left + self.sectionInset.right + (self.minimumInteritemSpacing * CGFloat(self.layoutType.cellsPerRow))
        let screenWidth: CGFloat = collectionView.bounds.width
        let overScreen: CGFloat = screenWidth - insets
        let cellWidth: CGFloat = overScreen / CGFloat(self.layoutType.cellsPerRow)
        
        self.itemSize = CGSize.init(width: cellWidth, height: cellWidth)
    }
}
