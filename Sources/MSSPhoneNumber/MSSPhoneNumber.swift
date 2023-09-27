//_________SKAIK_MO_________
//
//  MSSPhoneNumber.swift
//  MSSPhoneNumber
//
//  Created by Mohammed Skaik on 17/09/2023.
//

import Foundation
import UIKit

public class MSSPhoneNumber {
    private let countriesController = CountriesController()
    public var getSelectedCountry: ((Country) -> Void)?
    public init() { }
}

extension MSSPhoneNumber {
    public func showCountryPicker() {
        let vc = MSSCountryPicker()
        vc.getSelectedCountry = self.getSelectedCountry
        UIApplication.shared.rootViewController?.present(vc, animated: true)
    }

    public func isValid(fieldTitle: String = "Phone number", phone: String?) -> Bool {
        return PhoneValidator(field: fieldTitle).hasValidValue(phone ?? "")
    }

    public func checkTextInput(textField: UITextField, range: NSRange, text: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: text) ?? ""
        let maxLength = 10
        guard newText.count <= maxLength else { return false }
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: text)
        return allowedCharacters.isSuperset(of: characterSet)
    }

    public func getCountry(code: String) -> Country? {
        countriesController.getCountry(code: code)
    }
}
