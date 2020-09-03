//
//  HeadlinesFirstRowCell.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 03.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

final class HeadlinesFirstRowCell: UICollectionViewCell {
    
    private var imageView: UIImageView = UIImageView()
    private var titleView: UILabel = UILabel()
    
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
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
    }
}
