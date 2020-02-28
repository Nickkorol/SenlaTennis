//
//  GameCoordinatorImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 19.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class GameCoordinatorImpl {

    weak var root: UIViewController!
    weak var mainViewController: UIViewController!

    init(root: UIViewController, mainViewController: UIViewController) {
        self.root = root
        self.mainViewController = mainViewController
    }

}

extension GameCoordinatorImpl: GameCoordinator {

    var main: UIViewController? { return mainViewController }

    func run() {
        root.present(mainViewController, animated: true)
    }
    
    func backToRoot() {
        mainViewController.navigationController?.popToRootViewController(animated: true)
    }
}
