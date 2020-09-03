//
//  HeadlinesViewController.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 02.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

class HeadlinesViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        //collectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        //collectionViewLayout.itemSize = CGSize(width: 60, height: 60)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        //
        collectionView.backgroundColor = .blue
        //
        
        collectionView.dataSource = self
        //collectionView.delegate = self
        //collectionView.prefetchDataSource = self
        collectionView.register(HeadlinesFirstRowCell.self, forCellWithReuseIdentifier: HeadlinesFirstRowCell.identifier)
        collectionView.register(HeadlinesSecondRowCell.self, forCellWithReuseIdentifier: HeadlinesSecondRowCell.identifier)
        //collectionView.automaticallyAdjustsScrollIndicatorInsets = true
        //collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("STARTED! 20:28")
        
        //configureCollectionView()
        view.addSubview(collectionView)
        
        setConstraints()
    }
    
    /*
    private func configureCollectionView() {
        collectionView.backgroundColor = .blue
        
        let layout = UICollectionViewFlowLayout()
        
        collectionView.collectionViewLayout = layout
    }
    */
    
    private func setConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionViewConstraints: [NSLayoutConstraint] = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
}


// MARK: - UICollectionViewDataSource
extension HeadlinesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlinesFirstRowCell.identifier, for: indexPath)
        guard let headlineCell = cell as? HeadlinesFirstRowCell else {
            return cell
        }

        headlineCell.backgroundColor = .yellow
        
        return headlineCell
    }
}

