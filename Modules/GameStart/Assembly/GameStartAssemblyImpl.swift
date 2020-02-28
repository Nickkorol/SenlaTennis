//
//  GameStartAssemblyImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class GameStartAssemblyImpl: GameStartAssembly {
    
    private let root: UIViewController!
    private weak var appCoordinator: AppCoordinator?

    init(root: UIViewController, appCoordinator: AppCoordinator?) {
        self.root = root
        self.appCoordinator = appCoordinator
    }
    
    func assembly() -> GameStartCoordinator {
        let storyboard = UIStoryboard(name: "GameStartView", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "GameStartViewController") as? GameStartViewController else {
                   fatalError("GameStartViewController is needed")
               }
        let viewModel = GameStartViewModelImpl()
        controller.viewModel = viewModel

        let coordinator = GameStartCoordinatorImpl(root: root, mainViewController: controller, appCoordinator: appCoordinator)

        viewModel.coordinator = coordinator
        viewModel.view = controller

        return coordinator
    }
}
