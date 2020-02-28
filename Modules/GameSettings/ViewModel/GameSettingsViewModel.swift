//
//  GameSettingsViewModel.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

protocol GameSettingsViewModel {
    func doneDidPress(value: Int)
    func addNewPlayerDidPress()
    func amountOfPlayersChanged(amount: Int)
    func userDataChanged(player: Employee, index: Int)
    //func userDataChanged(player: Employee, index: Int, completionHandler: @escaping ([Employee], [Department]) -> ())
    func getDepartments(completionHandler: @escaping ([Department]) -> ())
    func getDepartmentsEmployees(departmentName: String, completionHandler: @escaping ([Employee]?, Bool) -> ())
}
