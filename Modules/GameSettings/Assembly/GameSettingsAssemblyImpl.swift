//
//  GameSettingsAssemblyImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class GameSettingsAssemblyImpl: GameSettingsAssembly {

    private let root: UIViewController!

    init(root: UIViewController) {
        self.root = root
    }

    func assembly() -> GameSettingsCoordinator {
        let storyboard = UIStoryboard(name: "GameSettings", bundle: nil)
        let identifier = String(describing: GameSettingsViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? GameSettingsViewController else {
            fatalError("GameSettingsViewController is needed")
        }
        let viewModel = GameSettingsViewModelImpl()
        controller.viewModel = viewModel

        let coordinator = GameSettingsCoordinatorImpl(root: root, mainViewController: controller)

        viewModel.coordinator = coordinator
        viewModel.view = controller
        return coordinator
    }
}
