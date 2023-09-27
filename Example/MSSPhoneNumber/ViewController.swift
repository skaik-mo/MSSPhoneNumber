//
//  ViewController.swift
//  MSSPhoneNumber
//
//  Created by skaik-mo on 09/24/2023.
//  Copyright (c) 2023 skaik-mo. All rights reserved.
//

import UIKit
import MSSPhoneNumber

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var phoneContainer: UIStackView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var checkButton: UIButton!

    // MARK: Properties
    let mssPhoneNumber = MSSPhoneNumber()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
}

// MARK: - Actions
private extension ViewController {
    @IBAction func action(_ sender: Any) {
        let isValid = mssPhoneNumber.isValid(fieldTitle: "Phone number", phone: self.phoneText.text)
        debugPrint("isValid =>> \(isValid)")
        debugPrint("phone =>> \(self.phoneText.text ?? "")")
    }

    @objc func showCountryPicker() {
        mssPhoneNumber.showCountryPicker()
    }
}

// MARK: - Configurations
private extension ViewController {
    func setUpView() {
        self.checkButton.layer.cornerRadius = 10
        self.phoneContainer.layer.cornerRadius = 10
        self.phoneContainer.layer.borderColor = UIColor.black.cgColor
        self.phoneContainer.layer.borderWidth = 1
        self.phoneText.keyboardType = .numberPad
        self.phoneText.delegate = self
        if let country: Country = self.mssPhoneNumber.getCountry(code: "PS") {
            self.setCode(country: country)
        }
        self.mssPhoneNumber.getSelectedCountry = { [weak self] country in
            self?.setCode(country: country)
        }
        let codeGesture = UITapGestureRecognizer(target: self, action: #selector(self.showCountryPicker))
        self.codeLabel.addGestureRecognizer(codeGesture)
        self.codeLabel.isUserInteractionEnabled = true
    }

    func setCode(country: Country) {
        self.codeLabel.text = "\(country.flag) +\(country.dialCode)"
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.mssPhoneNumber.checkTextInput(textField: textField, range: range, text: string)
    }
}
