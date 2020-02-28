//
//  GameStartViewModelImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

final class GameStartViewModelImpl {
    var coordinator: GameStartCoordinator!
    weak var view: GameStartViewInput?
}

extension GameStartViewModelImpl: GameStartViewModel {
    func historyDidPress() {
        coordinator.showHistory()
    }
    
    func settingsDidPress() {
        coordinator.showSettings()
    }
}
