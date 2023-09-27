//_________SKAIK_MO_________
//
//  ValidationRule.swift
//  MSSPhoneNumber
//
//  Created by Mohammed Skaik on 17/09/2023.
//

import Foundation
import UIKit

protocol ValidationRule {
    typealias ValueType = String
    var field: String { get set }

    func validate(_ value: ValueType) throws

    /// Validates whether a given value is considered valid according to the validation rules.
    func hasValidValue(_ value: ValueType) -> Bool
}

extension ValidationRule {

    func hasValidValue(_ value: ValueType) -> Bool {
        do {
            try NilValidationRule(field: self.field).validate(value)
            try validate(value)
            return true
        } catch let error {
            UIApplication.shared.rootViewController?.showError(message: error.localizedDescription)
            return false
        }
    }
}

// MARK: Available Validation Rules
struct NilValidationRule: ValidationRule {
    var field: String

    func validate(_ value: ValueType) throws {
        guard value._isValidValue else { throw ValidationError(errorDescription: Strings.INVALID_VALUE_MESSAGE.replacingOccurrences(of: "{field}", with: field)) }
    }

}

struct RegexValidationRule: ValidationRule {
    var field: String
    let regex: String

    func validate(_ value: ValueType) throws {
        guard value.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil else {
            throw ValidationError(errorDescription: Strings.INVALID_RANGE_MESSAGE.replacingOccurrences(of: "{field}", with: field))
        }
    }
}

struct CharacterCountValidationRule: ValidationRule {
    var field: String
    let minCount: Int?
    let maxCount: Int?
    var replacements: [String: Any?] = [:]

    init(field: String, minCount: Int?, maxCount: Int?) {
        self.field = field
        self.minCount = minCount
        self.maxCount = maxCount
        self.replacements = [
            "{field}": field,
            "{minimum}": minCount,
            "{maximum}": maxCount
        ]
    }

    func validate(_ value: ValueType) throws {
        guard !((value.count >= minCount ?? Int.min) && (value.count <= maxCount ?? Int.max)) else { return }
        var errorMsg = ""
        if let minimum = minCount, let maximum = maxCount {
            if minimum == maximum {
                errorMsg = replacements.reduce(Strings.INVALID_LENGTH_MINIMUM_EXACTLY_MESSAGE, { partialResult, replace in
                    partialResult.replacingOccurrences(of: replace.key, with: "\(replace.value ?? "")")
                })
            } else {
                errorMsg = replacements.reduce(Strings.INVALID_LENGTH_BETWEEN_MINIMUM_MAXIMUM_MESSAGE, { partialResult, replace in
                    partialResult.replacingOccurrences(of: replace.key, with: "\(replace.value ?? "")")
                })
            }
        } else if minCount != nil {
            errorMsg = replacements.reduce(Strings.INVALID_LENGTH_MINIMUM_MESSAGE, { partialResult, replace in
                partialResult.replacingOccurrences(of: replace.key, with: "\(replace.value ?? "")")
            })
        } else if maxCount != nil {
            errorMsg = replacements.reduce(Strings.INVALID_LENGTH_MAXIMUM_MESSAGE, { partialResult, replace in
                partialResult.replacingOccurrences(of: replace.key, with: "\(replace.value ?? "")")
            })
        }
        throw ValidationError(errorDescription: errorMsg)
    }
}
