//
//  AddPlayerCoordinator.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol AddPlayerCoordinator {
    var main: UIViewController? { get }
    func run()    
    func back()
}
