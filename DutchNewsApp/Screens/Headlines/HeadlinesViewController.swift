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
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        //
        collectionView.backgroundColor = .blue
        //
        
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.prefetchDataSource = self
        collectionView.register(HeadlinesFirstRowCell.self, forCellWithReuseIdentifier: HeadlinesFirstRowCell.identifier)
        collectionView.register(HeadlinesSecondRowCell.self, forCellWithReuseIdentifier: HeadlinesSecondRowCell.identifier)
        //collectionView.automaticallyAdjustsScrollIndicatorInsets = true
        //collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private var viewModel: HeadlinesViewModel!

    init(viewModel: HeadlinesViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEINIT HeadlinesViewController")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        setConstraints()
        
        loadItems(lastIndexPath: nil)
    }
    
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
        //return 10
        return viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlinesFirstRowCell.identifier, for: indexPath)
        guard let headlineCell = cell as? HeadlinesFirstRowCell else {
            return cell
        }

        headlineCell.backgroundColor = .yellow
        viewModel.configure(cell: headlineCell, indexPath: indexPath, width: collectionView.bounds.width)
        
        return headlineCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HeadlinesViewController: UICollectionViewDelegateFlowLayout {

    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 50)
        default:
            return CGSize(width: collectionView.bounds.width/3, height: 50)
        }
        
    }
    */
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}

// MARK: - Load
extension HeadlinesViewController {
    func loadItems(lastIndexPath: IndexPath?) {
        viewModel.loadItems(lastIndexPath: lastIndexPath) { [weak self] (result: Result<[IndexPath], Error>) in
            switch result {
            case .success(let indexPaths):
                // TODO
                print("OK")
                self?.reloadItemsIfNeeded(indexPaths: indexPaths)

            case .failure(let error):
                // TODO
                print("error")
                //self?.alertService.showMessage(error.description, viewController: self)
            }
        }
    }
    
    func reloadItemsIfNeeded(indexPaths: [IndexPath]) {
        collectionView.performBatchUpdates({ [weak self] in
            self?.collectionView.reloadItems(at: indexPaths)
        })
    }
    
    /*
    func reloadItemIfNeeded(itemIndexPath indexPath: IndexPath) {
        guard collectionView.indexPathsForVisibleItems.contains(indexPath) else {
            return
        }
        
        guard !collectionView.isDecelerating, !collectionView.isDragging else {
            return
        }
        
        collectionView.performBatchUpdates({ [weak self] in
            self?.collectionView.reloadItems(at: [indexPath])
        })
    }
    */
}
