//
//  GamesResultsCell.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 21.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class GamesResultsCell: UITableViewCell {
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var firstPlayerNameLabel: UILabel!
    @IBOutlet private var firstPlayerScoreLabel: UILabel!
    @IBOutlet private var secondPlayerScoreLabel: UILabel!
    @IBOutlet private var secondPlayerNameLabel: UILabel!
    
    func configure(date: Date, firstPlayerName: String, secondPlayerName: String, firstPlayerDepartment: String, secondPlayerDepartment: String, firstPlayerScore: Int, secondPlayerScore: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let dateString = dateFormatter.string(from: date)
        dateLabel.text = dateString
        firstPlayerNameLabel.text = firstPlayerName + " " + firstPlayerDepartment
        secondPlayerNameLabel.text = secondPlayerName + " " + secondPlayerDepartment
        firstPlayerScoreLabel.text = "\(firstPlayerScore)"
        secondPlayerScoreLabel.text = "\(secondPlayerScore)"
    }
    
}
