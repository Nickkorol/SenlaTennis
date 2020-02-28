//
//  GameViewController.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 19.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet private var firstPlayerLabel: UILabel!
    @IBOutlet private var secondPlayerLabel: UILabel!
    @IBOutlet private var gameLogsTableView: UITableView!
    @IBOutlet private var firstPlayerScoreButton: UIButton!
    @IBOutlet private var secondPlayerScoreButton: UIButton!
    @IBOutlet private var firstPlayerServiceView: UIView!
    @IBOutlet private var secondPlayerServiceView: UIView!
    
    var viewModel: GameViewModel!
    
    var firstPlayerScore: Int = 0
    var secondPlayerScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        gameLogsTableView.register(UINib(nibName: "GameLogsTableViewCell", bundle: nil), forCellReuseIdentifier: "GameLogsTableViewCell")
    }
    
    @IBAction func firstPlayerScoreButtonTapped(_ sender: UIButton) {
        viewModel.firstPlayerScored()
    }
    
    @IBAction func secondPlayerScoreButtonTapped(_ sender: UIButton) {
        viewModel.secondPlayerScored()
    }
    
}

extension GameViewController: GameViewInput {
    func displayAlertWithResults() {
        let message = "Игра окончена. Счет \(firstPlayerScore)-\(secondPlayerScore)"
        let alert = UIAlertController(title: "Игра окончена", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default) { [weak self] _ in
            self?.viewModel.resultsDismissed()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func configure(players: [Employee]) {
        if (players.count == 4) {
            firstPlayerLabel.text = players[0].name! + " и " + players[1].name!
            secondPlayerLabel.text = players[2].name! + " и " + players[3].name!
        } else {
            firstPlayerLabel.text = players[0].name
            secondPlayerLabel.text = players[1].name
        }
        firstPlayerServiceView.layer.cornerRadius = firstPlayerServiceView.frame.width / 2
        firstPlayerServiceView.clipsToBounds = true
        secondPlayerServiceView.layer.cornerRadius = secondPlayerServiceView.frame.width / 2
        secondPlayerServiceView.clipsToBounds = true
        secondPlayerServiceView.isHidden = true
    }
    
    func updateScore(firstPlayerScore: Int, secondPlayerScore: Int, coef: Int) {
        if ((firstPlayerScore + secondPlayerScore) % (coef*2) == 0) {
            firstPlayerServiceView.isHidden = false
            secondPlayerServiceView.isHidden = true
        } else if ((firstPlayerScore + secondPlayerScore) % coef == 0) {
            firstPlayerServiceView.isHidden = true
            secondPlayerServiceView.isHidden = false
        }
        firstPlayerScoreButton.setTitle("\(firstPlayerScore)", for: .normal)
        secondPlayerScoreButton.setTitle("\(secondPlayerScore)", for: .normal)
        self.firstPlayerScore = firstPlayerScore
        self.secondPlayerScore = secondPlayerScore
        gameLogsTableView.reloadData()
        
        if (((firstPlayerScore >= coef*5+1) || (secondPlayerScore >= coef*5+1)) && abs(firstPlayerScore-secondPlayerScore) > 1) {
            viewModel.gameIsOver(firstPlayerScore: firstPlayerScore, secondPlayerScore: secondPlayerScore)
        }
    }
}

extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstPlayerScore+secondPlayerScore
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameLogsTableViewCell", for: indexPath) as! GameLogsTableViewCell
        if indexPath.row == firstPlayerScore+secondPlayerScore-1 {
            cell.configure(firstPlayerScore: firstPlayerScore, secondPlayerScore: secondPlayerScore)
        }
        return cell
    }
    
}
