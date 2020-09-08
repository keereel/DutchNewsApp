//
//  FileLoader.swift
//  DutchNewsAppUITests
//
//  Created by Kirill Sedykh on 08.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation

final class FileLoader {
    static func loadJsonData(from file: String) -> Data? {
        guard let path = Bundle(for: FileLoader.self).path(forResource: file, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
                return nil
        }

        return data
    }
}
