//_________SKAIK_MO_________
//
//  CountriesController.swift
//  MSSPhoneNumber
//
//  Created by Mohammed Skaik on 17/09/2023.
//

import Foundation

class CountriesController {
    private var countries: [Country] = {
        var countries: [Country] = []
        do {
            let resource = "CountryCodes"
            guard let url = Bundle.framework.url(forResource: resource, withExtension: "json") else {
                debugPrint("MSSPhoneNumber >>> Can't find a bundle for the countries")
                return countries
            }
            let data = try Data(contentsOf: url)
            let array = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]]
            array?.forEach({ object in
                guard let name = object["name"],
                    let code = object["code"],
                    let dialCode = object["dialCode"],
                    let format = object["format"],
                    let flag = object["flag"],
                    let flagURL = object["flagURL"] else {
                    debugPrint("Must be valid json.")
                    return
                }
                countries.append(Country(name: name, code: code, dialCode: dialCode, format: format, flag: flag, flagURL: flagURL))
            })
        } catch {
            debugPrint("MSSPhoneNumber >>> \(error.localizedDescription)")
        }
        countries = countries.sorted(by: >)
        return countries
    }()

    func getCountries() -> [Country] {
        return countries
    }

    func getCountries(_ text: String) -> [Country] {
        let text = text.lowercased()
        return countries.filter({ $0.code.lowercased().contains(text) || $0.name.lowercased().contains(text) })
    }

    func getCountry(code: String) -> Country? {
        return countries.first(where: { $0.code.lowercased() == code.lowercased() })
    }
}
