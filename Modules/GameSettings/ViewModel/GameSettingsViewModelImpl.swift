//
//  GameSettingsViewModelImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

final class GameSettingsViewModelImpl {
    var coordinator: GameSettingsCoordinator!
    weak var view: GameSettingsViewInput?
    
    let coreDataStack = CoreDataStack.shared
    
    var chosenPlayers: [Employee] = []
}

extension GameSettingsViewModelImpl: GameSettingsViewModel {
    
    func userDataChanged(player: Employee, index: Int) {
        chosenPlayers[index] = player
        view?.doneBarButtonItemNeedsEnable(isReady: isAllDataSet())
    }
    
    func getDepartments(completionHandler: @escaping ([Department]) -> ()) {
        coreDataStack.getDepartments(completionHandler: completionHandler)
    }
    
    func getDepartmentsEmployees(departmentName: String, completionHandler: @escaping ([Employee]?, Bool) -> ()) {
        coreDataStack.getDepartmentsEmployees(departmentName: departmentName, completionHandler: completionHandler)
    }
    
    func amountOfPlayersChanged(amount: Int) {
        let coreDataStack = CoreDataStack.shared
        chosenPlayers.removeAll()
        for _ in 0..<amount {
            let player = Employee(context: coreDataStack.childManagedContext)
            chosenPlayers.append(player)
        }
    }
    
    func addNewPlayerDidPress() {
        coordinator.showNewPlayerAddition()
    }
    
    func doneDidPress(value: Int) {
        self.coordinator.goToGame(players: chosenPlayers)
    }
}

private extension GameSettingsViewModelImpl {
    func isAllDataSet() -> Bool {
        for i in 0..<chosenPlayers.count {
            guard let name = chosenPlayers[i].name, let department = chosenPlayers[i].department?.name else { return false }
            if (name.isEmpty || department.isEmpty) {
                return false
            }
        }
        return true
    }
}
