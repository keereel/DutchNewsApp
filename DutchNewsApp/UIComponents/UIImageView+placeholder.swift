//
//  UIImageView+placeholder.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 07.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

extension UIImageView {
    func setPlaceholder() {
        let img = UIImage(named: "no-photo")!.withRenderingMode(.alwaysTemplate)
        clipsToBounds = true
        tintColor = .white
        backgroundColor = .gray
        contentMode = .center
        image = img
    }
}
