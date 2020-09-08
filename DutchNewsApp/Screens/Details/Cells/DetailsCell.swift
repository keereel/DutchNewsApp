//
//  DetailsCell.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 08.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit
import Kingfisher

protocol DetailsCellOutput: AnyObject {
    func setImagePath(_ imagePath: String?)
    func configure(title: String, source: String, width: CGFloat)
}

final class DetailsCell: UICollectionViewCell {
    
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
        
        titleView.font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.bold)
        //titleView.backgroundColor = .green
        //titleView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        setConstraints()
    }
    
    private func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewConstraints: [NSLayoutConstraint] = [
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 16/9)
        ]
        imageViewConstraints.forEach { $0.priority = .required }
        NSLayoutConstraint.activate(imageViewConstraints)
        
        sourceView.translatesAutoresizingMaskIntoConstraints = false
        let sourceViewConstraints: [NSLayoutConstraint] = [
            sourceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        sourceView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
        ]
        sourceViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(sourceViewConstraints)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        let titleViewConstraints: [NSLayoutConstraint] = [
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: sourceView.bottomAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        titleViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(titleViewConstraints)
        

        
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

extension DetailsCell: DetailsCellOutput {
    
    func configure(title: String, source: String, width: CGFloat) {
        titleView.text = title
        sourceView.text = source
        
        print("HeadlinesFirstRowCell width = \(width)")
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
