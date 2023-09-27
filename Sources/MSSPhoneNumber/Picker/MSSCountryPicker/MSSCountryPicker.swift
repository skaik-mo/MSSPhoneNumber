//_________SKAIK_MO_________
//
//  MSSCountryPicker.swift
//  MSSPhoneNumber
//
//  Created by Mohammed Skaik on 17/09/2023.
//

import UIKit

class MSSCountryPicker: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
    private let countriesController = CountriesController()
    private var countries: [Country]
    var getSelectedCountry: ((Country) -> Void)?

    // MARK: Init
    init() {
        self.countries = countriesController.getCountries()
        super.init(nibName: nil, bundle: .framework)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
}

extension MSSCountryPicker: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchForText(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchForText(searchBar.text)
        searchBar.endEditing(true)
    }
}

// MARK: - Configurations
private extension MSSCountryPicker {
    func setUpView() {
        self.searchBar.searchTextField.font = .systemFont(ofSize: 14, weight: .regular)
        self.searchBar.searchTextField.textColor = .black
        self.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: Strings.SEARCH_TITLE, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        self.tableView.register(UINib(nibName: CountryTableViewCell.id, bundle: .framework), forCellReuseIdentifier: CountryTableViewCell.id)
        self.tableView.contentInset.top = 10
        self.tableView.contentInset.bottom = 10
        self.tableView.rowHeight = 40
    }

    func searchForText(_ text: String?) {
        guard let text, !text.isEmpty else {
            self.countries = self.countriesController.getCountries()
            self.tableView.reloadData()
            return
        }
        self.countries = self.countriesController.getCountries(text)
        self.tableView.reloadData()
    }
}

extension MSSCountryPicker: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.id) as? CountryTableViewCell else { return UITableViewCell() }
        cell.country = countries[indexPath.row]
        cell.configureCell()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.getSelectedCountry?(countries[indexPath.row])
        self.dismiss(animated: true)
    }
}
