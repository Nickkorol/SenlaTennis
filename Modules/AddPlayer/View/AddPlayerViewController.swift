//
//  AddPlayerViewController.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class AddPlayerViewController: UIViewController {

    var viewModel: AddPlayerViewModel!
    
    @IBOutlet weak var newPlayerNameTextField: UITextField!
    @IBOutlet weak var newPlayerDepartmentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func readyDidPress(_ sender: UIBarButtonItem) {
        guard let employeeName = newPlayerNameTextField.text, let employeeDepartment = newPlayerDepartmentTextField.text else { return }
        viewModel.checkIsRepeated(name: employeeName, department: employeeDepartment)
    }
    
}

extension AddPlayerViewController: AddPlayerViewInput {}
