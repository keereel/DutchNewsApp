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
    
    /*
    override func prepare() {
        headerAttributes = UICollectionViewLayoutAttributes(
            forSupplementaryViewOfKind: "ident",
            with: IndexPath(item: 0, section: 0))
        headerAttributes.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
    }
    */
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        /*
        if headerAttributes.frame.intersects(rect) {
            return [headerAttributes]
        }
        */
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        var updatedAttributes = [UICollectionViewLayoutAttributes]()
        
        print("INVOKED HeadlinesFlowLayout.layoutAttributesForElements")
        
        for itemAttributes in attributes {
            if itemAttributes.representedElementCategory == .cell {
                print("@  .cell \(itemAttributes.indexPath)")
                updatedAttributes.append(itemAttributes)
            } else if itemAttributes.representedElementCategory == .supplementaryView {
                print("@  .supple \(itemAttributes.indexPath)")
                if let swAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: itemAttributes.indexPath) {
                    swAttributes.indexPath = IndexPath(item: 3, section: 0)
                    updatedAttributes.append(swAttributes)
                    print("@  OK .supple \(itemAttributes.indexPath)")
                }
                
            }
        }
        
        var minYInRow: CGFloat = 0
        var someBottomPointInRow: CGFloat = 0
        var currentRow: [UICollectionViewLayoutAttributes] = []
        updatedAttributes.forEach { (itemAttributes) in
            if itemAttributes.representedElementCategory == .supplementaryView {
                return
            }
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
        
        /*
        // attempt show supplementary
        print("attributes before appended: \(attributes?.count)")
        let ip = IndexPath(item: 3, section: 0)
        var supAttrs = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: "test2", with: ip)
        print("supAttrs.frame \(supAttrs.frame)")
        //supAttrs.frame = CGRect(x: 0, y: 0, width: 375, height: 100)
        supAttrs.size = CGSize(width: 375, height: 150)
        attributes?.append(supAttrs)
        print("attributes after appended: \(attributes?.count)")
        */
        
        return updatedAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        print("INVOKED HeadlinesFlowLayout.layoutAttributesForItem")
        let itemAttributes = super.layoutAttributesForItem(at: indexPath)!
        print("  item \(indexPath.item) attributes.frame \(itemAttributes.frame)")
        
        return itemAttributes
    }
    
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let itemAttributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        
        return itemAttributes
        
    }
    
}
