//
//  DetailsAssembly.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 08.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation
import UIKit

final class DetailsAssembly {
    
    func assemble(items: [Article], for initialIndexPath: IndexPath) -> UIViewController {
        let viewModel = DetailsViewModelImpl(items: items, initialIndexPath: initialIndexPath)
        let controller = DetailsViewController(viewModel: viewModel)
        
        return controller
    }
}
