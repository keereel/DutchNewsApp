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

    private var cache: [UICollectionViewLayoutAttributes] = []
    
    /*
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        print("HeadlinesFlowLayout prepare")
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            //attributes.frame = insetFrame
            print("item \(item) attributes.frame \(attributes.bounds)")
            cache.append(attributes)
            
        }
    }
    */
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attrs = super.layoutAttributesForElements(in: rect)
        
        
        
        return attrs
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attrs = super.layoutAttributesForItem(at: indexPath)!
        print("item \(indexPath.item) attributes.frame \(attrs.frame)")
        
        return attrs
        //return cache[indexPath.item]
    }
}
