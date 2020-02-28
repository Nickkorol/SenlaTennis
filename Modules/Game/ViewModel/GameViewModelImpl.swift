//
//  GameViewModelImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 19.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

final class GameViewModelImpl {
    var coordinator: GameCoordinator!
    weak var view: GameViewInput?
    
    var players: [Employee]
    var coef: Int = 2
    var firstPlayersPoints: Int = 0
    var secondPlayersPoints: Int = 0
    
    init(players: [Employee]) {
        self.players = players
    }
}

extension GameViewModelImpl: GameViewModel {
    
    func viewDidLoad() {
        firstPlayersPoints = 0
        secondPlayersPoints = 0
        view?.configure(players: players)
        if players.count == 4 {
            coef = 5
        }
    }
    
    func firstPlayerScored() {
        firstPlayersPoints+=1
        view?.updateScore(firstPlayerScore: firstPlayersPoints, secondPlayerScore: secondPlayersPoints, coef: coef)
    }
    
    func secondPlayerScored() {
        secondPlayersPoints+=1
        view?.updateScore(firstPlayerScore: firstPlayersPoints, secondPlayerScore: secondPlayersPoints, coef: coef)
    }
    
    func gameIsOver(firstPlayerScore: Int, secondPlayerScore: Int) {
        view?.displayAlertWithResults()
        
        let coreDataStack = CoreDataStack.shared
        coreDataStack.gameIsOver(firstScore: firstPlayerScore, secondScore: secondPlayerScore, players: self.players)
        
    }
    
    func resultsDismissed() {
        coordinator.backToRoot()
    }
    
}
