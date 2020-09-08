//
//  HeadlinesFlowLayout.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 05.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation
import UIKit

final class HeadlinesFlowLayout: UICollectionViewFlowLayout {
    
    private let webViewIndexPath: IndexPath = IndexPath(item: 3, section: 0)
    
    private var cellSpacing: CGFloat {
        return minimumInteritemSpacing
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        var updatedAttributes = [UICollectionViewLayoutAttributes]()
        var webViewAttributes: UICollectionViewLayoutAttributes?
        
        for itemAttributes in attributes {
            if itemAttributes.representedElementCategory == .cell {
                updatedAttributes.append(itemAttributes)
            } else if itemAttributes.representedElementCategory == .supplementaryView {
                if let webViewUpdatedAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: itemAttributes.indexPath) {
                    webViewUpdatedAttributes.indexPath = webViewIndexPath
                    webViewAttributes = webViewUpdatedAttributes
                }
            }
        }
        
        // Move supplementary view to proper position, which assigned in webViewIndexPath
        if let webViewAttributes = webViewAttributes {
            var maxY: CGFloat = 0
            
            for itemAttributes in updatedAttributes {
                guard itemAttributes.representedElementCategory != .supplementaryView else { continue }
                guard itemAttributes.indexPath.item < webViewIndexPath.item else { break }
                    
                itemAttributes.frame.origin.y = itemAttributes.frame.origin.y - webViewAttributes.frame.height
                maxY = max(maxY, itemAttributes.frame.maxY)
            }
            
            webViewAttributes.frame.origin.y = maxY + cellSpacing
            // Eventually, append modified webViewAttributes to attributes array
            updatedAttributes.append(webViewAttributes)
        }
        
        // Top alignment of two-column cells. This mechanism works not for only items with index 1 and 2, but for all items, which arranged in two columns
        var minYInRow: CGFloat = 0
        var someBottomPointInRow: CGFloat = 0
        var currentRow: [UICollectionViewLayoutAttributes] = []
        updatedAttributes.forEach { (itemAttributes) in
            if itemAttributes.representedElementCategory == .supplementaryView {
                return
            }

            if itemAttributes.frame.origin.y >= someBottomPointInRow {
                /*
                It means new row started, so, let's set minY as origin.y for each row item
                 and then clear currentRow, minYInRow an someBottomPointInRow for the new current
                 row
                */
                currentRow.forEach { (currenRowItemAttributes) in
                    currenRowItemAttributes.frame.origin.y = minYInRow
                }
                currentRow = []
                minYInRow = itemAttributes.frame.origin.y
                someBottomPointInRow = itemAttributes.frame.maxY
            }
            minYInRow = min(minYInRow, itemAttributes.frame.origin.y)
            currentRow.append(itemAttributes)
        }
        currentRow.forEach { (currenRowItemAttributes) in
            currenRowItemAttributes.frame.origin.y = minYInRow
        }
        
        return updatedAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let itemAttributes = super.layoutAttributesForItem(at: indexPath)!
        
        return itemAttributes
    }
    
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let itemAttributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        
        return itemAttributes
    }
}
