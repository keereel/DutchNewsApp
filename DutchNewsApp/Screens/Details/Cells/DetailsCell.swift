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
    func configure(title: String,
                   description: String,
                   author: String,
                   url: String,
                   source: String,
                   width: CGFloat)
}

final class DetailsCell: UICollectionViewCell {
    
    private var imageView: UIImageView = UIImageView()
    private var titleView: TitleLabel = TitleLabel()
    private var sourceView: SourceLabel = SourceLabel()
    private var descriptionView: UILabel = UILabel()
    
    private var widthConstraint: NSLayoutConstraint!
    
    private let contentSpacing: UIOffset = UIOffset(horizontal: 8, vertical: 8)
 
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
        contentView.addSubview(descriptionView)
        
        titleView.font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.bold)
        
        descriptionView.numberOfLines = 0
        descriptionView.isUserInteractionEnabled = true
        
        setConstraints()
    }
    
    private func setConstraints() {
        let contentViewMargins = contentView.layoutMarginsGuide
        
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
            sourceView.leadingAnchor.constraint(equalTo: contentViewMargins.leadingAnchor),
            sourceView.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                            constant: contentSpacing.vertical),
        ]
        sourceViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(sourceViewConstraints)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        let titleViewConstraints: [NSLayoutConstraint] = [
            titleView.leadingAnchor.constraint(equalTo: contentViewMargins.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentViewMargins.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: sourceView.bottomAnchor,
                                           constant: contentSpacing.vertical),
        ]
        titleViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(titleViewConstraints)
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        let textViewConstraints: [NSLayoutConstraint] = [
            descriptionView.leadingAnchor.constraint(equalTo: contentViewMargins.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: contentViewMargins.trailingAnchor),
            descriptionView.topAnchor.constraint(equalTo: titleView.bottomAnchor,
                                           constant: contentSpacing.vertical*2),
        ]
        textViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(textViewConstraints)
        
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
    
    func configure(title: String,
                   description: String,
                   author: String,
                   url: String,
                   source: String,
                   width: CGFloat) {
        
        titleView.text = title
        sourceView.text = source
        
        let resultAttributedString = NSMutableAttributedString()
        
        if !author.isEmpty {
            let authorFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.systemYellow]
            let authorAttributedString = NSAttributedString(string: "Author: \(author)", attributes: authorFontAttributes)
            resultAttributedString.append(authorAttributedString)
            resultAttributedString.append(NSAttributedString(string: "\n\n"))
        }
        
        if !description.isEmpty {
            let descriptionFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.baseTextColor]
            let descriptionAttributedString = NSAttributedString(string: description, attributes: descriptionFontAttributes)
            resultAttributedString.append(descriptionAttributedString)
            resultAttributedString.append(NSAttributedString(string: "\n\n"))
        }
        
        if !url.isEmpty, let anUrl = URL(string: url) {
            let urlAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.baseTextColor]
            let urlAttributedString = NSMutableAttributedString(string: url, attributes: urlAttributes)
            urlAttributedString.addAttribute(NSAttributedString.Key.link, value: anUrl, range: url.nsRange())
            
            resultAttributedString.append(urlAttributedString)
            resultAttributedString.append(NSAttributedString(string: "\n\n"))
        }
        
        descriptionView.attributedText = resultAttributedString
        
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
