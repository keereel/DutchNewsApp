//
//  HeadlinesViewModel.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 04.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation
import UIKit

protocol HeadlinesViewModel {
    var count: Int { get }
    
    func item(for indexPath: IndexPath) -> Article
    
    func loadItems(lastIndexPath: IndexPath?, completion: @escaping (Result<[IndexPath], Error>) -> Void)
    
    func configure(cell: HeadlinesCellOutput, indexPath: IndexPath, width: CGFloat)
}

final class HeadlinesViewModelImpl: HeadlinesViewModel {

    private let firstPageIndex = 1
    private let objectsPerPage = 10
    
    
    private let apiClient: NewsApiClient = NewsApiClientImpl()
    
    private let itemsQueue = DispatchQueue(label: "HeadlinesViewModel.itemsQueue", attributes: .concurrent)
    
    private var items: [Article] = []
    
    var count: Int {
        items.count
    }
    
    deinit {
        print("DEINIT HeadlinesViewModel")
    }
    
    func item(for indexPath: IndexPath) -> Article {
        return item(for: indexPath.row)
    }
    
    private func item(for index: Int) -> Article {
        itemsQueue.sync(flags: .barrier) {
            return items[index]
        }
    }
    
    // MARK: Fetch data
    
    func loadItems(lastIndexPath: IndexPath?, completion: @escaping (Result<[IndexPath], Error>) -> Void) {
        //
        apiClient.fetchHeadlines(page: 1) { [weak self] (result) in
            switch result {
            case .success(let headlinesResponse):
                self?.updateDataSourceAndUI(with: headlinesResponse.articles,
                                      forPageNumber: 1,
                                      completion: completion)
                /*
                self.items.append(contentsOf: headlinesResponse.articles)
                print("HeadlinesViewModelImpl.loadItems success")
                headlinesResponse.articles.forEach{ print("  \($0.title)")}
                 DispatchQueue.main.async {
                     completion(Result.success([]))
                 }
                */
                
                /*
                // stopped here 20200906 2114
                let page = 1 // TODO calculate page when implement pagination
                let firstIndexOnPage = self.minIndex(onPage: page)
                let lastIndexOnPage = firstIndexOnPage + self.items.count - 1
                objectsQueue.sync(flags: .barrier) {
                  for index in firstIndexOnPage...lastIndexOnPage {
                    if self.objects.count - 1 < index {
                      self.objects.append(artObjects[index-firstIndexOnPage])
                    } else {
                      self.objects[index] = artObjects[index-firstIndexOnPage]
                    }
                  }
                }
                */
                
            case .failure(let error):
                // TODO
                DispatchQueue.main.async {
                    completion(Result.failure(error))
                }
            }
        }
    }
    
    
    private func updateDataSourceAndUI(with fetchedItems: [Article],
                                       forPageNumber page: Int,
                                       completion: @escaping (Result<[IndexPath], Error>) -> Void) {
        guard fetchedItems.count > 0 else {
            DispatchQueue.main.async {
                completion(Result.success([]))
            }
            return
        }
        
        // update dataSource
        let firstIndexOnPage = minIndex(onPage: page)
        let lastIndexOnPage = firstIndexOnPage + fetchedItems.count - 1
        itemsQueue.sync(flags: .barrier) {
            for index in firstIndexOnPage...lastIndexOnPage {
                if self.items.count - 1 < index {
                    self.items.append(fetchedItems[index-firstIndexOnPage])
                } else {
                    self.items[index] = fetchedItems[index-firstIndexOnPage]
                }
            }
        }
        
        // update UI
        var indexPaths: [IndexPath] = []
        for index in firstIndexOnPage...lastIndexOnPage {
            indexPaths.append(IndexPath(row: index, section: 0))
        }
        DispatchQueue.main.async {
            completion(Result.success(indexPaths))
        }
    }
    
    // MARK: Configure cells
    
    func configure(cell: HeadlinesCellOutput, indexPath: IndexPath, width: CGFloat) {
        let item = items[indexPath.row]
        
        cell.configure(title: item.title ?? "", source: item.source.name ?? "", width: width)

    }
    
    // MARK: Helpers
    
    func minIndex(onPage page: Int) -> Int {
      return (page - firstPageIndex) * objectsPerPage
    }
    
    func maxIndex(onPage page: Int) -> Int {
      return (page - firstPageIndex + 1) * objectsPerPage - 1
    }
}
