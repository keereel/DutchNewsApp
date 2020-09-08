//
//  DetailsViewController.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 08.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation
import UIKit

final class DetailsViewController: UIViewController {
    
    private var viewModel: DetailsViewModel!
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.setContentOffset(.zero, animated: false)
        collectionView.isPagingEnabled = true
        //
        //collectionView.backgroundColor = .yellow
        //
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //collectionView.prefetchDataSource = self
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: DetailsCell.identifier)
        
        //collectionView.automaticallyAdjustsScrollIndicatorInsets = true
        //collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    init(viewModel: DetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        print("init DetailsViewModel items: \(viewModel.count)")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print("DEINIT DetailsViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(collectionView)
        view.backgroundColor = .black
        setConstraints()
        
        collectionView.reloadData()
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionViewConstraints: [NSLayoutConstraint] = [
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
}


extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCell.identifier, for: indexPath)
        guard let detailsCell = cell as? DetailsCell else {
            return cell
        }
        
        print("@DetailsViewController cellForItemAt \(indexPath)")
        //detailsCell.backgroundColor = .blue
        viewModel.configure(cell: detailsCell, indexPath: indexPath, width: collectionView.bounds.width)
        
        return detailsCell
    }
}
