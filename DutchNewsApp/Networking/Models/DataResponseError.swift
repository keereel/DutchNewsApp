//
//  DataResponseError.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 03.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    case invalidUrl
    
    var description: String {
        switch self {
        case .network:
            return "Unable to load data due to network connection issues"
        case .decoding:
            return "Unable to load data due to invalid data received from server"
        case .invalidUrl:
            return "Unable to load data due to invalid URL"
        }
    }
}
