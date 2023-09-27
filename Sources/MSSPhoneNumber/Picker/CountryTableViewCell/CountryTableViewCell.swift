//_________SKAIK_MO_________
//
//  CountryTableViewCell.swift
//  MSSPhoneNumber
//
//  Created by Mohammed Skaik on 17/09/2023.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dialCodeLabel: UILabel!

    var country: Country?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell() {
        if let country {
            self.flagLabel.text = country.flag
            self.nameLabel.text = country.name
            self.dialCodeLabel.text = "+\(country.dialCode)"
        } else {
            self.flagLabel.text = nil
            self.nameLabel.text = nil
            self.dialCodeLabel.text = nil
        }
    }
}
