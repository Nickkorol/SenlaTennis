//
//  AddPlayerViewModelImpl.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

final class AddPlayerViewModelImpl {
    var coordinator: AddPlayerCoordinator!
    weak var view: AddPlayerViewInput?
    
    let coreDataStack = CoreDataStack.shared
    var currentDepartment: Department?
}

extension AddPlayerViewModelImpl: AddPlayerViewModel {
    
    func checkIsRepeated(name: String, department: String) {
        coreDataStack.checkIsRepeated(name: name, department: department) { [weak self] isRepeated in
            if !isRepeated {
                self?.coordinator.back()
            }
        }
    }
    
    func playerHasAdded() {
        coordinator.back()
    }
    
}
