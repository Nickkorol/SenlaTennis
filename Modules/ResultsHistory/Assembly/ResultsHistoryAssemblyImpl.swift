//
//  ResultsHistoryAssemblyImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 21.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class ResultsHistoryAssemblyImpl: ResultsHistoryAssembly {

    private let root: UIViewController!

    init(root: UIViewController) {
        self.root = root
    }

    func assembly() -> ResultsHistoryCoordinator {
        let storyboard = UIStoryboard(name: "ResultsHistory", bundle: nil)
        let identifier = String(describing: ResultsHistoryViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? ResultsHistoryViewController else {
            fatalError("ResultsHistoryViewController is needed")
        }
        let viewModel = ResultsHistoryViewModelImpl()
        controller.viewModel = viewModel

        let coordinator = ResultsHistoryCoordinatorImpl(root: root, mainViewController: controller)

        viewModel.coordinator = coordinator
        viewModel.view = controller
        return coordinator
    }
}
