//
//  NewsApiClient.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 02.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation

protocol NewsApiClient {
    typealias completionHandler = (Result<HeadlinesResponse, DataResponseError>) -> Void
    
    func fetchHeadlines(page: Int, completion: @escaping completionHandler)
}

final class NewsApiClientImpl: NewsApiClient {
    
    private let session: URLSession
    private let apiKey = "fc69f71be70c4af78f93ecf90cbfbb1e"
    //https://newsapi.org/v2/top-headlines?country=nl&apiKey=fc69f71be70c4af78f93ecf90cbfbb1e&page=0
    private var basePath: String {
        "https://newsapi.org/v2/top-headlines?country=nl&apiKey=\(apiKey)"
    }
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    deinit {
        print("DEINIT NewsApiClientImpl")
    }
    
    func fetchHeadlines(page: Int, completion: @escaping completionHandler) {
        let urlString = basePath + "&p=\(page)"
        guard let url = URL(string: urlString) else {
            completion(Result.failure(DataResponseError.invalidUrl))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data else {
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            
            guard var decodedResponse = try? JSONDecoder().decode(HeadlinesResponse.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            
            //decodedResponse.pageNumber = page
            completion(Result.success(decodedResponse))
        }
        dataTask.resume()
    }
}
