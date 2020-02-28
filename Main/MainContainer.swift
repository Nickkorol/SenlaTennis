//
//  MainContainer.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class MainContainer: UINavigationController {

    override func show(_ vc: UIViewController, sender: Any?) {
        pushViewController(vc, animated: true)
    }

}
