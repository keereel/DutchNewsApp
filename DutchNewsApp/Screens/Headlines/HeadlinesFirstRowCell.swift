//
//  HeadlinesFirstRowCell.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 03.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

protocol HeadlinesCellOutput: AnyObject {
    //func setImagePath(_ imagePath: String)
    //func setTitle(_ text: String)
    //func setDescription(_ text: String?)
    func configure(title: String, width: CGFloat)
}

final class HeadlinesFirstRowCell: UICollectionViewCell {
    
    private var imageView: UIImageView = UIImageView()
    private var titleView: UILabel = UILabel()
    private var widthConstraint: NSLayoutConstraint!
    
    /*
    private lazy var widthConstraint: NSLayoutConstraint = {
        let constraint = NSLayoutConstraint(
            item: self.contentView,
            //item: self.titleView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 250)
        
        return constraint
    }()
    */
 
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        
        titleView.numberOfLines = 0
        titleView.backgroundColor = .green
        //
        
        //
        
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
        imageViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(imageViewConstraints)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleViewConstraints: [NSLayoutConstraint] = [
            titleView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
        ]
        titleViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(titleViewConstraints)
        
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let contentViewConstraints: [NSLayoutConstraint] = [
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        contentViewConstraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(contentViewConstraints)
        
        
        widthConstraint = NSLayoutConstraint(
            item: contentView,
            //item: titleView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 200)
        widthConstraint.priority = .defaultHigh
        //NSLayoutConstraint.activate([widthConstraint])
    }
}

extension HeadlinesFirstRowCell: HeadlinesCellOutput {
    
    func configure(title: String, width: CGFloat) {
        titleView.text = title
        
        print("HeadlinesFirstRowCell width = \(width)")
        widthConstraint.constant = width
        widthConstraint.isActive = true
        
    }
    
    /*
    func setTitle(_ text: String) {
        titleView.text = text
    }
    */
}


