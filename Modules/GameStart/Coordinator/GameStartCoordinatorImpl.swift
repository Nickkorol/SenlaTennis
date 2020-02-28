//
//  GameStartCoordinatorImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class GameStartCoordinatorImpl {
    weak var root: UIViewController!
    weak var mainViewController: UIViewController!
    weak var appCoordinator: AppCoordinator?

    init(root: UIViewController, mainViewController: UIViewController, appCoordinator: AppCoordinator?) {
        self.root = root
        self.mainViewController = mainViewController
        self.appCoordinator = appCoordinator
    }
}

extension GameStartCoordinatorImpl: GameStartCoordinator {
    
    var main: UIViewController? {
        return mainViewController
    }
    
    func run() {
        root.present(mainViewController, animated: true)
    }
    
    func showSettings() {
        let assembly = GameSettingsAssemblyImpl(root: root)
        let coordinator = assembly.assembly()
        guard let viewController = coordinator.main else { fatalError() }
        mainViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showHistory() {
        let assembly = ResultsHistoryAssemblyImpl(root: root)
        let coordinator = assembly.assembly()
        guard let viewController = coordinator.main else { fatalError() }
        mainViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
