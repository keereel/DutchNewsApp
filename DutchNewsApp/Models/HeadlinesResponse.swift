//
//  HeadlinesResponse.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 03.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation

struct HeadlinesResponse: Codable {
    let totalResults: Int
    let articles: [Article]
}
