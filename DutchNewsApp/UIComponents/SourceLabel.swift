//
//  SourceLabel.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 06.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

final class SourceLabel: UILabel {
    
    private var insets: UIEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }
    
    private func commonInit() {
        font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        textColor = .white
        backgroundColor = .blueLink
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + insets.left + insets.right,
                      height: size.height + insets.top + insets.bottom)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (insets.left + insets.right)
        }
    }
}
