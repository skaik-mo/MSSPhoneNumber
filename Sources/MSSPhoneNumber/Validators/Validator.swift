//_________SKAIK_MO_________
//
//  Validator.swift
//  MSSPhoneNumber
//
//  Created by Mohammed Skaik on 17/09/2023.
//

import Foundation
import UIKit

protocol Validator {
    typealias ValueType = String
    var field: String { get set }
    /// An array of validation rules that apply to the data being validated.
    var validationRules: [ValidationRule] { get }
    /// Validates a given value and throw error if any
    func validate(_ value: ValueType) throws
    /// Validates whether a given value is considered valid according to the validation rules.
    func hasValidValue(_ value: ValueType) -> Bool
}

extension Validator {
    func validate(_ value: ValueType) throws {
        for validationRule in validationRules {
            try validationRule.validate(value)
        }
    }

    func hasValidValue(_ value: ValueType) -> Bool {
        do {
            try NilValidationRule(field: field).validate(value)
            try validate(value)
            return true
        } catch let error {
            UIApplication.shared.rootViewController?.showError(message: error.localizedDescription)
            return false
        }
    }
}
