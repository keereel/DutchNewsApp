//
//  DetailsViewModel.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 08.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsViewModel {
    var count: Int { get }
    
    var initialIndexPath: IndexPath { get }
    
    func item(for indexPath: IndexPath) -> Article
    
    func configure(cell: DetailsCellOutput, indexPath: IndexPath, width: CGFloat)
}

final class DetailsViewModelImpl: DetailsViewModel {
    
    let initialIndexPath: IndexPath
    
    private var items: [Article] = []
    var count: Int {
        items.count
    }
    
    init(items: [Article], initialIndexPath: IndexPath) {
        self.items = items
        self.initialIndexPath = initialIndexPath
    }
    
    deinit {
        print("DEINIT DetailsViewModel")
    }
    
    func item(for indexPath: IndexPath) -> Article {
        return item(for: indexPath.row)
    }
    
    private func item(for index: Int) -> Article {
        return items[index]
    }
    
    // MARK: - Configure cells
    
    func configure(cell: DetailsCellOutput, indexPath: IndexPath, width: CGFloat) {
        let item = items[indexPath.row]
        
        cell.configure(title: item.title ?? "",
                       description: item.description ?? "",
                       author: item.author ?? "",
                       url: item.url ?? "",
                       source: item.source.name ?? "",
                       width: width)
        cell.setImagePath(item.urlToImage)
    }
}
