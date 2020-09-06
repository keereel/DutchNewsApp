//
//  SourceLabel.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 06.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

final class SourceLabel: UILabel {
    
    private var topInset: CGFloat = 4
    private var bottomInset: CGFloat = 4
    private var leftInset: CGFloat = 4
    private var rightInset: CGFloat = 4
    
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
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
