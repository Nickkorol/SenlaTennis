//
//  GameStartViewController.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class GameStartViewController: UIViewController {
    
    var viewModel: GameStartViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func gameSettingsButtonTapped(_ sender: UIButton) {
        viewModel.settingsDidPress()
    }
    
    @IBAction func gameHistoryButtonTapped(_ sender: UIButton) {
        viewModel.historyDidPress()
    }
}

extension GameStartViewController: GameStartViewInput {
    
}
