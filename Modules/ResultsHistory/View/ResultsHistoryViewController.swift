//
//  ResultsHistoryViewController.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 21.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class ResultsHistoryViewController: UIViewController {

    var viewModel: ResultsHistoryViewModel!
    
    @IBOutlet private var gamesTableView: UITableView!
    var games: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        gamesTableView.register(UINib(nibName: "GamesResultsCell", bundle: nil), forCellReuseIdentifier: "GamesResultsCell")
        viewModel.viewDidLoad()
    }

}

extension ResultsHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GamesResultsCell", for: indexPath) as! GamesResultsCell
        let game = games[indexPath.row]
        guard let date = game.date, let players = game.players else {
            return cell
        }
        var firstPlayerName = ""
        var secondPlayerName = ""
        var firstPlayerDepartment = ""
        var secondPlayerDepartment = ""
        
        for i in 0...players.count - 1 {
            guard let playerName = (players[i] as! Employee).name,
                let playerDepartment = (players[i] as! Employee).department?.name else { return cell }
            if (players.count / (i+1) > 1) {
                firstPlayerName += playerName + " "
                firstPlayerDepartment += playerDepartment + " "
            } else {
                secondPlayerName += playerName + " "
                secondPlayerDepartment += playerDepartment + " "
            }
        }
        
        cell.configure(date: date,
                       firstPlayerName: firstPlayerName,
                       secondPlayerName: secondPlayerName,
                       firstPlayerDepartment: firstPlayerDepartment,
                       secondPlayerDepartment: secondPlayerDepartment,
                       firstPlayerScore: Int(game.firstScore),
                       secondPlayerScore: Int(game.secondScore))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.games = viewModel.deleteGame(game:games[indexPath.row], indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ResultsHistoryViewController: ResultsHistoryViewInput {
    
    func showGames(games: [Game]) {
        self.games = games
        gamesTableView.reloadData()
    }
}
