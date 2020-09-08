//
//  String+NSRange.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 08.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation

extension String {
    public func nsRange() -> NSRange {
        return NSRange(self.startIndex..., in: self)
    }
}
