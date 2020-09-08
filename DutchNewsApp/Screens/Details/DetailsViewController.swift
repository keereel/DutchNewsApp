//
//  DetailsViewController.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 08.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation
import UIKit

final class DetailsViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        //
        collectionView.backgroundColor = .orange
        //
        
        //collectionView.dataSource = self
        //collectionView.delegate = self
        
        //collectionView.prefetchDataSource = self
        collectionView.register(HeadlinesFirstRowCell.self, forCellWithReuseIdentifier: HeadlinesFirstRowCell.identifier)
        
        //collectionView.register(HeadlinesWebView.self, forSupplementaryViewOfKind: "test2", withReuseIdentifier: "ident")
        collectionView.register(HeadlinesWebView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeadlinesWebView.identifier)
        
        //collectionView.automaticallyAdjustsScrollIndicatorInsets = true
        //collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    
}
