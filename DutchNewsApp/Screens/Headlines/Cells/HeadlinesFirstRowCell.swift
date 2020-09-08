//
//  HeadlinesFirstRowCell.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 03.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit
import Kingfisher

final class HeadlinesFirstRowCell: UICollectionViewCell {
    
    private var imageView: UIImageView = UIImageView()
    private var titleView: UILabel = LargeTitleLabel()
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
        
        setConstraints()
    }
    
    private func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewConstraints: [NSLayoutConstraint] = [
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 16/9)
        ]
        imageViewConstraints.forEach { $0.priority = .required }
        NSLayoutConstraint.activate(imageViewConstraints)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        let titleViewConstraints: [NSLayoutConstraint] = [
            titleView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ]
        titleViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(titleViewConstraints)
        
        sourceView.translatesAutoresizingMaskIntoConstraints = false
        let sourceViewConstraints: [NSLayoutConstraint] = [
            sourceView.topAnchor.constraint(equalTo: imageView.topAnchor),
            sourceView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ]
        sourceViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(sourceViewConstraints)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let contentViewConstraints: [NSLayoutConstraint] = [
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        contentViewConstraints.forEach { $0.priority = .defaultHigh }
        //contentViewConstraints.forEach { $0.priority = .required }
        NSLayoutConstraint.activate(contentViewConstraints)
        
        widthConstraint = NSLayoutConstraint(
            item: contentView,
            //item: titleView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 1)
        //widthConstraint.priority = .defaultHigh
        widthConstraint.priority = .required
    }
}

extension HeadlinesFirstRowCell: HeadlinesCellOutput {
    
    func configure(title: String, source: String, width: CGFloat) {
        titleView.text = title
        sourceView.text = source
        
        widthConstraint.constant = width
        widthConstraint.isActive = true
    }
    
    func setImagePath(_ imagePath: String?) {
        guard let imagePath = imagePath else {
            imageView.setPlaceholder()
            return
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let url = URL(string: imagePath)
        let scale = UIScreen.main.scale
        let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: 100 * scale, height: 100 * scale), mode: .aspectFill)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, options: [.backgroundDecode,
                                                   .processor(resizingProcessor)])
    }
}
