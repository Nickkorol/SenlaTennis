//
//  GameAssemblyImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 19.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class GameAssemblyImpl: GameAssembly {

    private let root: UIViewController!
    let players: [Employee]

    init(root: UIViewController, players: [Employee]) {
        self.root = root
        self.players = players
    }

    func assembly() -> GameCoordinator {
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        let identifier = String(describing: GameViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? GameViewController else {
            fatalError("GameViewController is needed")
        }
        let viewModel = GameViewModelImpl(players: players)
        controller.viewModel = viewModel

        let coordinator = GameCoordinatorImpl(root: root, mainViewController: controller)

        viewModel.coordinator = coordinator
        viewModel.view = controller
        return coordinator
    }
}
