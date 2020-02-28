//
//  GameSettingsViewController.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class GameSettingsViewController: UIViewController {

    var viewModel: GameSettingsViewModel!
    @IBOutlet private var numberOfPlayersSegmentedControl: UISegmentedControl!
    @IBOutlet private var playersNamesTableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.amountOfPlayersChanged(amount: currentAmountOfPlayers())
        doneButton.isEnabled = false
        playersNamesTableView.register(UINib(nibName: "GameSettingsCell", bundle: nil), forCellReuseIdentifier: "GameSettingsCell")
    }
    
    @IBAction func segmentedControlDidPress(_ sender: UISegmentedControl) {
        viewModel.amountOfPlayersChanged(amount: currentAmountOfPlayers())
        playersNamesTableView.reloadData()
    }
    
    @IBAction func doneDidPress(_ sender: UIButton) {
        viewModel.doneDidPress(value: currentAmountOfPlayers())
    }
    @IBAction func addNewPlayer(_ sender: UIBarButtonItem) {
        viewModel.addNewPlayerDidPress()
    }
    
}

extension GameSettingsViewController: GameSettingsViewInput {
    func doneBarButtonItemNeedsEnable(isReady: Bool) {
        doneButton.isEnabled = isReady
    }
}

extension GameSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAmountOfPlayers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameSettingsCell", for: indexPath) as? GameSettingsCell else { fatalError() }
        cell.delegate = self
        cell.configure(number: indexPath.row)
        return cell
    }
    
}

private extension GameSettingsViewController {
    func currentAmountOfPlayers() -> Int {
        guard let chosenValue = numberOfPlayersSegmentedControl.titleForSegment(at: numberOfPlayersSegmentedControl.selectedSegmentIndex),
        let intChosenValue = Int(chosenValue) else { return 0 }
        return intChosenValue
    }
}

extension GameSettingsViewController: GameSettingsCellDelegate {
    
    func getDepartments(_ cell: GameSettingsCell) {
        viewModel.getDepartments() { departments in
            cell.didGetDepartments(departments: departments)
        }
    }
    
    func getDepartmentsEmployees(_ cell: GameSettingsCell, departmentName: String) {
        viewModel.getDepartmentsEmployees(departmentName: departmentName){ players, isVisible in
            cell.didGetPlayers(players: players, isVisible: isVisible)
        }
    }
    
    func playerDataChanged(player: Employee?, index: Int?) {
        guard let player = player, let index = index else { return }
        viewModel.userDataChanged(player: player, index: index)        
    }
}
