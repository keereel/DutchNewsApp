//
//  HeadlinesAssembly.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 04.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import Foundation
import UIKit

final class HeadlinesAssembly {
    
    func assemble() -> UIViewController {
        let viewModel = HeadlinesViewModelImpl()
        let controller = HeadlinesViewController(viewModel: viewModel)
        
        return controller
    }
}
