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
        //let collectionViewLayout = UICollectionViewFlowLayout()
        let flowLayout = HeadlinesFlowLayout()
        //collectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        //
        collectionView.backgroundColor = .blue
        //
        
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.prefetchDataSource = self
        collectionView.register(HeadlinesFirstRowCell.self, forCellWithReuseIdentifier: HeadlinesFirstRowCell.identifier)
        collectionView.register(HeadlinesSecondRowCell.self, forCellWithReuseIdentifier: HeadlinesSecondRowCell.identifier)
        collectionView.register(HeadlinesRegularCell.self, forCellWithReuseIdentifier: HeadlinesRegularCell.identifier)
        
        //collectionView.register(HeadlinesWebView.self, forSupplementaryViewOfKind: "test2", withReuseIdentifier: "ident")
        collectionView.register(HeadlinesWebView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeadlinesWebView.identifier)
        
        //collectionView.automaticallyAdjustsScrollIndicatorInsets = true
        //collectionView.backgroundColor = .clear
        
        return collectionView
    }()

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
}
// MARK: - UICollectionViewDelegateFlowLayout
extension HeadlinesViewController: UICollectionViewDelegateFlowLayout {

    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        //case 0:
        //    return CGSize(width: collectionView.bounds.width, height: 50)
        default:
            return CGSize(width: collectionView.bounds.width/2, height: 20)
        }
        
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
        }
    }
    
    func refreshCollectionView(indexPaths: [IndexPath]) {
        print("  indexPaths.count:\(indexPaths.count)")
        guard indexPaths.count > 0 else { return }
        if indexPaths[0].item == 0 {
            collectionView.reloadData()
        } else {
            collectionView.insertItems(at: indexPaths)
        }
    }
}
