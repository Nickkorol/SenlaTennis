//
//  GameSettingsCoordinatorImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class GameSettingsCoordinatorImpl {

    weak var root: UIViewController!
    weak var mainViewController: UIViewController!

    init(root: UIViewController, mainViewController: UIViewController) {
        self.root = root
        self.mainViewController = mainViewController
    }

}

extension GameSettingsCoordinatorImpl: GameSettingsCoordinator {

    var main: UIViewController? { return mainViewController }

    func run() {
        root.present(mainViewController, animated: true)
    }
    
    func back() {
        mainViewController.navigationController?.popViewController(animated: true)
    }
    
    func goToGame(players: [Employee]) {
        let assembly = GameAssemblyImpl(root: root, players: players)
        let coordinator = assembly.assembly()
        guard let viewController = coordinator.main else { fatalError() }
        mainViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showNewPlayerAddition() {
        let assembly = AddPlayerAssemblyImpl(root: root)
        let coordinator = assembly.assembly()
        guard let viewController = coordinator.main else { fatalError() }
        mainViewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
