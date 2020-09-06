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
    
    private var cellSpacing: CGFloat {
        return minimumInteritemSpacing
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        //print("INVOKED HeadlinesFlowLayout.layoutAttributesForElements")
        
        var minYInRow: CGFloat = 0
        var someBottomPointInRow: CGFloat = 0
        var currentRow: [UICollectionViewLayoutAttributes] = []
        attributes?.forEach { (itemAttributes) in
            //print("  \(itemAttributes.indexPath.item) attribute.frame \(itemAttributes.frame.origin)")
            if itemAttributes.frame.origin.y >= someBottomPointInRow {
                //print("  new row, old minYInRow \(minYInRow)")
                /*
                It means new row started, so, let's set minY as origin.y for each row item
                 and then clear currentRow, minYInRow an someBottomPointInRow for the new current
                 row
                */
                currentRow.forEach { (currenRowItemAttributes) in
                    //print("--row \(currenRowItemAttributes.indexPath.item) y set \(minYInRow)")
                    currenRowItemAttributes.frame.origin.y = minYInRow
                }
                currentRow = []
                minYInRow = itemAttributes.frame.origin.y
                someBottomPointInRow = itemAttributes.frame.maxY
            }
            minYInRow = min(minYInRow, itemAttributes.frame.origin.y)
            currentRow.append(itemAttributes)
            //print("  minYInRow \(minYInRow)")
        }
        currentRow.forEach { (currenRowItemAttributes) in
            currenRowItemAttributes.frame.origin.y = minYInRow
        }
        
        return attributes
    }
    
    /*
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        print("INVOKED HeadlinesFlowLayout.layoutAttributesForItem")
        let itemAttributes = super.layoutAttributesForItem(at: indexPath)!
        print("  item \(indexPath.item) attributes.frame \(itemAttributes.frame)")
        
        return itemAttributes
    }
    */
}
