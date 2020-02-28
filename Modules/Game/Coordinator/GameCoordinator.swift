//
//  GameCoordinator.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 19.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol GameCoordinator {
    var main: UIViewController? { get }
    func run()
    func backToRoot()
}
