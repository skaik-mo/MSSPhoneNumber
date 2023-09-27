//_________SKAIK_MO_________
//
//  PhoneValidator.swift
//  MSSPhoneNumber
//
//  Created by Mohammed Skaik on 17/09/2023.
//

import Foundation

struct PhoneValidator: Validator {
    var field: String = "Phone number"
    var validationRules: [ValidationRule] = []

    init(field: String) {
        self.field = field
        self.validationRules = [
            RegexValidationRule(field: field, regex: #"^\d+$"#),
            CharacterCountValidationRule(field: field, minCount: 5, maxCount: 10)
        ]
    }
}
