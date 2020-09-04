//
//  HeadlinesViewModel.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 04.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation

protocol HeadlinesViewModel {
    var count: Int { get }
    
    func item(for indexPath: IndexPath) -> Article
    
    func loadItems(lastIndexPath: IndexPath?, completion: @escaping (Result<[IndexPath], Error>) -> Void)
}

final class HeadlinesViewModelImpl: HeadlinesViewModel {

    //private let objectsPerPage = 10
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
        apiClient.fetchHeadlines(page: 1) { (result) in
            switch result {
            case .success(let headlinesResponse):
                self.items.append(contentsOf: headlinesResponse.articles)
                print("HeadlinesViewModelImpl.loadItems success")
                headlinesResponse.articles.forEach{ print("  \($0.title)")}
                completion(Result.success([]))
            case .failure(let error):
                // TODO
                print("error \(error)")
            }
        }
    }
    
}
