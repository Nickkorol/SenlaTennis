//
//  ResultsHistoryCoordinatorImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 21.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class ResultsHistoryCoordinatorImpl {

    weak var root: UIViewController!
    weak var mainViewController: UIViewController!

    init(root: UIViewController, mainViewController: UIViewController) {
        self.root = root
        self.mainViewController = mainViewController
    }

}

extension ResultsHistoryCoordinatorImpl: ResultsHistoryCoordinator {

    var main: UIViewController? { return mainViewController }

    func run() {
        root.present(mainViewController, animated: true)
    }
}
