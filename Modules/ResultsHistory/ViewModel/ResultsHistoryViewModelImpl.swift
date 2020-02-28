//
//  ResultsHistoryViewModelImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 21.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

final class ResultsHistoryViewModelImpl {
    var coordinator: ResultsHistoryCoordinator!
    weak var view: ResultsHistoryViewInput?
    
    lazy var coreDataStack = CoreDataStack.shared
    var games: [Game] = []
}

extension ResultsHistoryViewModelImpl: ResultsHistoryViewModel {

    func viewDidLoad() {
        games = coreDataStack.getGames()
        view?.showGames(games: games)
    }
    
    func deleteGame(game: Game, indexPath: IndexPath) -> [Game] {
        coreDataStack.deleteGame(game: game)        
        games.remove(at: indexPath.row)
        return games
    }

}
