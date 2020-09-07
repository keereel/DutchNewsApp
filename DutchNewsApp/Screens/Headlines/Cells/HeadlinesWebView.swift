//
//  HeadlinesWebView.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 07.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit
import WebKit

final class HeadlinesWebView: UICollectionReusableView {
    
    //private var webView: WKWebView = WKWebView()
    private var webView: UIView = UIView()
    
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
        addSubview(webView)
    
        webView.backgroundColor = .red
        
        
        setConstraints()
    }
    
    private func setConstraints() {
            webView.translatesAutoresizingMaskIntoConstraints = false
            let imageViewConstraints: [NSLayoutConstraint] = [
                webView.topAnchor.constraint(equalTo: topAnchor),
                webView.bottomAnchor.constraint(equalTo: bottomAnchor),
                webView.leadingAnchor.constraint(equalTo: leadingAnchor),
                webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
            imageViewConstraints.forEach { $0.priority = .required }
            NSLayoutConstraint.activate(imageViewConstraints)
    }
}
