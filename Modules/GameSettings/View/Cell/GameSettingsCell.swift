//
//  GameSettingsCell.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

protocol GameSettingsCellDelegate: class {
    func playerDataChanged(player: Employee?, index: Int?)
    func getDepartments(_ cell: GameSettingsCell)
    func getDepartmentsEmployees(_ cell: GameSettingsCell, departmentName: String)
}

class GameSettingsCell: UITableViewCell {
    
    lazy var coreDataStack = CoreDataStack.shared
    
    var employees: [Employee]?
    var departments: [Department]?
    
    var numberOfRow: Int?
    
    weak var delegate: GameSettingsCellDelegate?

    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var departmentTextField: UITextField!
    
    func configure(number: Int) {
        numberLabel.text = "\(number + 1)"
        numberOfRow = number
        nameTextField.isEnabled = false
        configureTextInputs()
        delegate?.getDepartments(self)
    }
    
    func didGetDepartments(departments: [Department]) {
        self.departments = departments
    }
    
    func didGetPlayers(players: [Employee]?, isVisible: Bool) {
        self.employees = players
        nameTextField.isEnabled = isVisible
    }
    
}

extension GameSettingsCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 2 {
            return employees?.count ?? 0
        } else {
            return departments?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 2 {
            return employees?[row].name
        } else {
            return departments?[row].name
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 2 {
            nameTextField.text = employees?[row].name
            delegate?.playerDataChanged(player: employees?[row], index: numberOfRow)
        } else {
            departmentTextField.text = departments?[row].name
            guard let department = departmentTextField.text else { return }
            delegate?.getDepartmentsEmployees(self, departmentName: department)
        }
    }
}

extension GameSettingsCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == nameTextField || textField == departmentTextField) {
            return false
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == nameTextField && nameTextField.text!.isEmpty) {
            nameTextField.text = employees?[0].name
            delegate?.playerDataChanged(player: employees?[0], index: numberOfRow)
        } else {
            if (departmentTextField.text!.isEmpty) {
                departmentTextField.text = departments?[0].name
            }
            nameTextField.text = ""
            guard let department = departmentTextField.text else { return false }
            delegate?.getDepartmentsEmployees(self, departmentName: department)
        }
        return true
    }

}

private extension GameSettingsCell {
    func configureTextInputs() {
        nameTextField.delegate = self
        departmentTextField.delegate = self
        
        let namesPicker = UIPickerView()
        namesPicker.delegate = self
        namesPicker.dataSource = self
        namesPicker.tag = 2
        nameTextField.inputView = namesPicker
        
        let departmentsPicker = UIPickerView()
        departmentsPicker.delegate = self
        departmentsPicker.dataSource = self
        departmentsPicker.tag = 1
        departmentTextField.inputView = departmentsPicker
    }

}
