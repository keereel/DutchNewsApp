//
//  HeadlinesRegularCell.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 06.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

final class HeadlinesRegularCell: UICollectionViewCell {
    
    private var imageView: UIImageView = UIImageView()
    private var titleView: UILabel = TitleLabel()
    private var sourceView: UILabel = SourceLabel()
    
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
        contentView.addSubview(sourceView)
        
        imageView.backgroundColor = .white
        
        titleView.backgroundColor = .green
        
        setConstraints()
    }
    
    private func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewConstraints: [NSLayoutConstraint] = [
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            //imageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            //imageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 16/9)
        ]
        imageViewConstraints.forEach { $0.priority = .required }
        NSLayoutConstraint.activate(imageViewConstraints)
        
        sourceView.translatesAutoresizingMaskIntoConstraints = false
        let sourceViewConstraints: [NSLayoutConstraint] = [
            sourceView.topAnchor.constraint(equalTo: contentView.topAnchor),
            sourceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ]
        sourceViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(sourceViewConstraints)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        let titleViewConstraints: [NSLayoutConstraint] = [
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            //titleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleView.topAnchor.constraint(equalTo: sourceView.bottomAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            //titleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        titleViewConstraints.forEach { $0.priority = .required }
        NSLayoutConstraint.activate(titleViewConstraints)
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let contentViewConstraints: [NSLayoutConstraint] = [
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: imageView.heightAnchor)
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
}

extension HeadlinesRegularCell: HeadlinesCellOutput {
    
    func configure(title: String, source: String, width: CGFloat) {
        titleView.text = title
        sourceView.text = source
        
        print("HeadlinesSecondRowCell width = \(width)")
        widthConstraint.constant = width
        widthConstraint.isActive = true
    }
}
