//
//  TitleLabel.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 06.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

final class TitleLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    private func commonInit() {
        font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        textColor = .white
        numberOfLines = 0
    }
}
