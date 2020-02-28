//
//  AddPlayerAssemblyImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class AddPlayerAssemblyImpl: AddPlayerAssembly {

    private let root: UIViewController!

    init(root: UIViewController) {
        self.root = root
    }

    func assembly() -> AddPlayerCoordinator {
        let storyboard = UIStoryboard(name: "AddPlayer", bundle: nil)
        let identifier = String(describing: AddPlayerViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? AddPlayerViewController else {
            fatalError("AddPlayerViewController is needed")
        }
        let viewModel = AddPlayerViewModelImpl()
        controller.viewModel = viewModel

        let coordinator = AddPlayerCoordinatorImpl(root: root, mainViewController: controller)

        viewModel.coordinator = coordinator
        viewModel.view = controller
        return coordinator
    }
}
