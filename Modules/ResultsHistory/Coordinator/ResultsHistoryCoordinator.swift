//
//  ResultsHistoryCoordinator.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 21.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol ResultsHistoryCoordinator {
    var main: UIViewController? { get }
    func run()
}
