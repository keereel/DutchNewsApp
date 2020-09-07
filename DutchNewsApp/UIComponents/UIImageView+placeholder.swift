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
        tintColor = .white
        //backgroundColor = .black
        backgroundColor = .gray
        contentMode = .scaleAspectFit
        image = img
    }
}
