//
//  HeadlinesViewController.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 02.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

class HeadlinesViewController: UIViewController {
    
    private var viewModel: HeadlinesViewModel!
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = HeadlinesFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.prefetchDataSource = self
        //collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = self.refreshControl
        
        collectionView.register(HeadlinesFirstRowCell.self, forCellWithReuseIdentifier: HeadlinesFirstRowCell.identifier)
        collectionView.register(HeadlinesSecondRowCell.self, forCellWithReuseIdentifier: HeadlinesSecondRowCell.identifier)
        collectionView.register(HeadlinesRegularCell.self, forCellWithReuseIdentifier: HeadlinesRegularCell.identifier)
        
        collectionView.register(HeadlinesWebView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeadlinesWebView.identifier)
        
        //collectionView.automaticallyAdjustsScrollIndicatorInsets = true
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.baseTintColor
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        
        return refreshControl
    }()
    
    @objc private func refreshControlPulled() {
        collectionView.refreshControl?.beginRefreshing()
        loadItems(lastIndexPath: nil)
        collectionView.refreshControl?.endRefreshing()
    }

    init(viewModel: HeadlinesViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print("DEINIT HeadlinesViewController")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionView.addSubview(refreshControl)
        view.addSubview(collectionView)
        setConstraints()
        
        loadItems(lastIndexPath: nil)
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


// MARK: - UICollectionViewDataSource
extension HeadlinesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("HeadlinesViewController.cellForItemAt indexPath: \(indexPath)")
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlinesFirstRowCell.identifier, for: indexPath)
            guard let headlineCell = cell as? HeadlinesFirstRowCell else {
                return cell
            }

            headlineCell.backgroundColor = .yellow
            viewModel.configure(cell: headlineCell, indexPath: indexPath, width: collectionView.bounds.width)
            
            return headlineCell
        case 1, 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlinesSecondRowCell.identifier, for: indexPath)
            guard let headlineCell = cell as? HeadlinesSecondRowCell else {
                return cell
            }

            headlineCell.backgroundColor = .yellow
            viewModel.configure(cell: headlineCell, indexPath: indexPath, width: collectionView.bounds.width/2 - 0.5)
            
            return headlineCell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlinesRegularCell.identifier, for: indexPath)
            guard let headlineCell = cell as? HeadlinesRegularCell else {
                return cell
            }

            headlineCell.backgroundColor = .yellow
            viewModel.configure(cell: headlineCell, indexPath: indexPath, width: collectionView.bounds.width)
            
            return headlineCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        print("collectionView.viewForSupplementaryElementOfKind indexPath \(indexPath)")
        
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeadlinesWebView.identifier,
            for: indexPath) as? HeadlinesWebView
            else {
                return UICollectionReusableView()
        }
        
        print("collectionView.viewForSupplementaryElementOfKind OK indexPath \(indexPath)")
        
        return supplementaryView

    }
}

// MARK: - UICollectionViewDelegate
extension HeadlinesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsAssembly = DetailsAssembly()
        let detailsViewController = detailsAssembly.assemble(items: viewModel.allItems(), for: indexPath)
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print("HeadlinesViewController.willDisplay indexPath: \(indexPath)")
        if indexPath.item == viewModel.count - 1 {
            print("LOAD!")
            for aa in collectionView.indexPathsForVisibleItems {
                print("  \(aa.item)")
            }
        }
    }
    */
}
// MARK: - UICollectionViewDelegateFlowLayout
extension HeadlinesViewController: UICollectionViewDelegateFlowLayout {

    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /*
        switch indexPath.row {
        //case 0:
        //    return CGSize(width: collectionView.bounds.width, height: 50)
        default:
            return CGSize(width: collectionView.bounds.width/2, height: 20)
        }
        */
        //return UICollectionViewFlowLayout.automaticSize
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 85.0)
    }
}

/*
// MARK: - UICollectionViewDataSourcePrefetching
extension HeadlinesViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        print("@INVOKED HeadlinesViewController.prefetchItemsAt")
        
        for indexPath in indexPaths {
            print("@ indexPath \(indexPath)")
            //loadArtObject(at: indexPath)
        }
    }
}
*/
 
// MARK: - Load
extension HeadlinesViewController {
    
    func loadItems(lastIndexPath: IndexPath?) {
        viewModel.loadItems(lastIndexPath: lastIndexPath) { [weak self] (result: Result<[IndexPath], Error>) in
            switch result {
            case .success(let indexPaths):
                self?.refreshCollectionView(indexPaths: indexPaths)
            case .failure(let error):
                // TODO
                print("error \(error)")
                //self?.alertService.showMessage(error.description, viewController: self)
            }
            self?.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    func refreshCollectionView(indexPaths: [IndexPath]) {
        print("  indexPaths.count:\(indexPaths.count)")
        //collectionView.collectionViewLayout.invalidateLayout()
        guard indexPaths.count > 0 else { return }
        if indexPaths[0].item == 0 {
            collectionView.reloadData()
        } else {
            collectionView.insertItems(at: indexPaths)
        }
    }
}
