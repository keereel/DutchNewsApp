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
    
    func assemble(items: [Article]) -> UIViewController {
        let viewModel = DetailsViewModelImpl(items: items)
        let controller = DetailsViewController(viewModel: viewModel)
        
        return controller
    }
}
