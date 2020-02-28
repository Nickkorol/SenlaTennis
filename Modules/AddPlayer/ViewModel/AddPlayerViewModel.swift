//
//  AddPlayerViewModel.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

protocol AddPlayerViewModel {
    func playerHasAdded()
    func checkIsRepeated(name: String, department: String)
}
