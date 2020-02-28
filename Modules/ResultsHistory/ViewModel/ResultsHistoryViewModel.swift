//
//  ResultsHistoryViewModel.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 21.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

protocol ResultsHistoryViewModel {
    func viewDidLoad()
    func deleteGame(game: Game, indexPath: IndexPath) -> [Game]
}
