//
//  HTTPURLResponse+successStatusCode.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 03.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
