//
//  HeadlinesSecondRowCell.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 03.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

final class HeadlinesSecondRowCell: UICollectionViewCell {
    
    private var imageView: UIImageView = UIImageView()
    private var titleView: UILabel = UILabel()
    private var widthConstraint: NSLayoutConstraint!
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    // MARK: - Setup UI
    private func setupCell() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        
        imageView.backgroundColor = .white
        
        titleView.numberOfLines = 0
        titleView.backgroundColor = .green
        
        setConstraints()
    }
    
    private func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewConstraints: [NSLayoutConstraint] = [
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            //imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 16/9)
        ]
        imageViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(imageViewConstraints)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        let titleViewConstraints: [NSLayoutConstraint] = [
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        titleViewConstraints.forEach { $0.priority = .required }
        NSLayoutConstraint.activate(titleViewConstraints)
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let contentViewConstraints: [NSLayoutConstraint] = [
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        contentViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(contentViewConstraints)
        
        widthConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 1)
        widthConstraint.priority = .defaultHigh
        
    }
    
    /*
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        //titleView.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    */
    
}

extension HeadlinesSecondRowCell: HeadlinesCellOutput {
    
    func configure(title: String, width: CGFloat) {
        titleView.text = title
        //titleView.sizeToFit()
        
        print("HeadlinesSecondRowCell width = \(width)")
        widthConstraint.constant = width
        widthConstraint.isActive = true
        
        layoutIfNeeded()
    }
}
