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

protocol FeedFlowLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
    func collectionView(_ collectionView: UICollectionView, cellContainsAdAtIndexPath indexPath: IndexPath) -> Bool
    func collectionView(_ collectionView: UICollectionView, heightForAdAtIndexPath indexPath: IndexPath) -> CGFloat
}

class FeedFlowLayout: UICollectionViewFlowLayout {
    weak var delegate: FeedFlowLayoutDelegate?
    
    private(set) var layoutType: FeedLayoutType = .list
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentBounds = CGRect.zero
    private var contentHeight: CGFloat = 0

    init(layoutType: FeedLayoutType) {
        super.init()
        self.layoutType = layoutType
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.cache.removeAll()
        self.contentBounds = .zero
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView else { return }
        self.cache.removeAll()
        self.contentBounds = .zero
        
        self.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.minimumInteritemSpacing = .list == self.layoutType ? 0 : 1
        self.minimumLineSpacing = .list == self.layoutType ? 0 : 1
        
        let insets = self.sectionInset.left + self.sectionInset.right + (self.minimumInteritemSpacing * CGFloat(self.layoutType.cellsPerRow))
        let screenWidth: CGFloat = collectionView.bounds.width
        let overScreen: CGFloat = screenWidth - insets

        switch self.layoutType {
        case .grid:
            self.handleGridLayout(collectionView, overScreen: overScreen)
        case .list:
            self.handleListLayout(collectionView, overScreen: overScreen)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        self.cache.forEach({ attribute in
            guard attribute.frame.intersects(rect) else { return }
            layoutAttributes.append(attribute)
        })
        
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard 0 <= indexPath.row,
              0 <= indexPath.section,
              self.cache.count - 1 >= indexPath.row else { return nil }
        return self.cache[indexPath.item]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }
    
    override var collectionViewContentSize: CGSize {
        return self.contentBounds.size
    }
}

extension FeedFlowLayout {
    private func handleGridLayout(_ collectionView: UICollectionView, overScreen: CGFloat) {
        let cellWidth: CGFloat = overScreen / CGFloat(self.layoutType.cellsPerRow)
        self.itemSize = CGSize.init(width: cellWidth, height: cellWidth)
    }

    private func handleListLayout(_ collectionView: UICollectionView, overScreen: CGFloat) {
        guard 0 != collectionView.numberOfSections, self.cache.isEmpty else { return }
                
        var lastFrame: CGRect = .zero
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let cellHeight: CGFloat = self.delegate?.collectionView(collectionView, heightForItemAtIndexPath: indexPath) ?? .zero
            let segmentFrame = CGRect(x: 0,
                                      y: lastFrame.maxY,
                                      width: overScreen,
                                      height: cellHeight)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = segmentFrame
            self.cache.append(attributes)
            
            
            if self.delegate?.collectionView(collectionView, cellContainsAdAtIndexPath: indexPath) ?? false,
               let adHeight = self.delegate?.collectionView(collectionView, heightForAdAtIndexPath: indexPath) {
                lastFrame = CGRect.init(x: segmentFrame.minX,
                                        y: segmentFrame.minY,
                                        width: segmentFrame.width,
                                        height: segmentFrame.height + adHeight)
            } else {
                lastFrame = segmentFrame
            }
            self.contentBounds = self.contentBounds.union(lastFrame)
        }
    }
}
