//
//  HeadlinesCellOutput.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 06.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

protocol HeadlinesCellOutput: AnyObject {
    func setImagePath(_ imagePath: String?)
    //func setTitle(_ text: String)
    //func setDescription(_ text: String?)
    func configure(title: String, source: String, width: CGFloat)
}
