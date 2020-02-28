//
//  GameLogsTableViewCell.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 19.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class GameLogsTableViewCell: UITableViewCell {

    @IBOutlet private var firstPlayerPointLogLabel: UILabel!
    @IBOutlet private var secondPlayerPointLogLabel: UILabel!
    
    func configure(firstPlayerScore: Int, secondPlayerScore: Int) {
        firstPlayerPointLogLabel.text = "\(firstPlayerScore)"
        secondPlayerPointLogLabel.text = "\(secondPlayerScore)"
    }
    
}
