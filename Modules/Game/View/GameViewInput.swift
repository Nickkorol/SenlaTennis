//
//  GameViewInput.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 19.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

protocol GameViewInput: class {
    func configure(players: [Employee])
    func updateScore(firstPlayerScore: Int, secondPlayerScore: Int, coef: Int)
    func displayAlertWithResults()
}
