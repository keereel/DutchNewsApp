//
//  Cell+Identifier.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 03.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

extension UICollectionReusableView {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
