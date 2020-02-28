//
//  GameViewModel.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 19.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

protocol GameViewModel {
    func viewDidLoad()
    func firstPlayerScored()
    func secondPlayerScored()
    func gameIsOver(firstPlayerScore: Int, secondPlayerScore: Int)
    func resultsDismissed()
}
