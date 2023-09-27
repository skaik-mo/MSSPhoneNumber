//_________SKAIK_MO_________
//
//  Country.swift
//  MSSPhoneNumber
//
//  Created by Mohammed Skaik on 17/09/2023.
//

import Foundation

public class Country {
    public var name: String
    public var code: String
    public var dialCode: String
    public var format: String
    public var flag: String
    public var flagURL: String

    init(name: String, code: String, dialCode: String, format: String, flag: String, flagURL: String) {
        self.name = name
        self.code = code
        self.dialCode = dialCode
        self.format = format
        self.flag = flag
        self.flagURL = flagURL
    }

    static func > (next: Country, previous: Country) -> Bool {
        return previous.name > next.name
    }
}
